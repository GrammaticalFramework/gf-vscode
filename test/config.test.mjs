import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const readJson = (p) => JSON.parse(readFileSync(join(root, p), 'utf8'));

const pkg = readJson('package.json');
const langConfig = readJson('language-configuration.json');
const grammar = readJson('syntaxes/gf.tmLanguage.json');

// https://code.visualstudio.com/api/language-extensions/language-configuration-guide
const LANG_CONFIG_KEYS = new Set([
  'comments', 'brackets', 'colorizedBracketPairs', 'autoClosingPairs',
  'autoCloseBefore', 'surroundingPairs', 'folding', 'wordPattern',
  'indentationRules', 'onEnterRules',
]);

test('language configuration has only keys VS Code understands', () => {
  for (const key of Object.keys(langConfig)) {
    assert.ok(LANG_CONFIG_KEYS.has(key), `unknown key: ${key}`);
  }
});

test('language configuration regexes compile as JavaScript RegExps', () => {
  const patterns = [langConfig.wordPattern, ...Object.values(langConfig.indentationRules ?? {})];
  for (const p of patterns.filter(Boolean)) {
    assert.doesNotThrow(() => new RegExp(p), `invalid regex: ${p}`);
  }
});

test('indentation rules behave on typical GF lines', () => {
  const inc = new RegExp(langConfig.indentationRules.increaseIndentPattern);
  const dec = new RegExp(langConfig.indentationRules.decreaseIndentPattern);
  assert.match('concrete FooEng of Foo = {', inc);
  assert.match("  lin' = table {", inc);
  assert.doesNotMatch('  x = {s = "a"} ;', inc);
  assert.match('  }', dec);
  assert.doesNotMatch('  x = y ;', dec);
});

test('word pattern keeps primes and underscores inside identifiers', () => {
  const word = new RegExp(langConfig.wordPattern, 'g');
  assert.deepEqual('lin Wine\' = mk_N x ;'.match(word), ['lin', "Wine'", 'mk_N', 'x']);
});

const openOf = (pair) => (Array.isArray(pair) ? pair[0] : pair.open);

test('no auto-closing of < or \' (conflicts with -> / => and primed identifiers)', () => {
  const opens = langConfig.autoClosingPairs.map(openOf);
  assert.ok(!opens.includes('<'));
  assert.ok(!opens.includes("'"));
  assert.ok(!langConfig.brackets.some(([open]) => open === '<'));
});

test('comment tokens match the grammar', () => {
  assert.equal(langConfig.comments.lineComment, '--');
  assert.deepEqual(langConfig.comments.blockComment, ['{-', '-}']);
});

test('grammar keyword lists have no duplicates', () => {
  const seen = new Map();
  for (const rule of grammar.patterns) {
    if (!rule.name || !/^(keyword|support)\./.test(rule.name)) continue;
    const alt = rule.match.match(/\(([\w|]+)\)/);
    if (!alt) continue;
    for (const word of alt[1].split('|')) {
      assert.ok(!seen.has(word), `"${word}" in both ${seen.get(word)} and ${rule.name}`);
      seen.set(word, rule.name);
    }
  }
});

test('grammar has no empty or ignored top-level fields', () => {
  assert.ok(!('firstLineMatch' in grammar) || grammar.firstLineMatch !== '');
  assert.equal(grammar.scopeName, pkg.contributes.grammars[0].scopeName);
});

test('files referenced by package.json exist', () => {
  const paths = [
    pkg.icon,
    ...pkg.contributes.languages.flatMap((l) => [l.configuration, l.icon?.light, l.icon?.dark]),
    ...pkg.contributes.grammars.map((g) => g.path),
  ].filter(Boolean);
  for (const p of paths) {
    assert.ok(existsSync(join(root, p)), `missing: ${p}`);
  }
});

test('engines.vscode supports every contribution used', () => {
  const [major, minor] = pkg.engines.vscode.replace(/^\D*/, '').split('.').map(Number);
  if (pkg.contributes.languages.some((l) => l.icon)) {
    // Language icons were added in VS Code 1.64.
    assert.ok(major > 1 || minor >= 64, `engines.vscode ${pkg.engines.vscode} < 1.64`);
  }
});

test('CHANGELOG has an entry for the current version', () => {
  const changelog = readFileSync(join(root, 'CHANGELOG.md'), 'utf8');
  assert.match(changelog, new RegExp(`^## ${pkg.version.replace(/\./g, '\\.')}$`, 'm'));
});
