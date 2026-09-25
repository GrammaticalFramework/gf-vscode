# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A purely declarative VS Code extension that adds syntax highlighting for Grammatical Framework (`.gf`) files. There is no extension code and no build step; `node_modules` exists only for the test tooling. Everything the extension does is wired up in the `contributes` section of `package.json`.

## Layout

- `package.json` registers the `gf` language (the `.gf` extension, file icon, language configuration) and points the grammar at scope `source.gf`.
- `syntaxes/gf.tmLanguage.json` is the TextMate grammar. It is a flat `patterns` list with no `repository`. Scope names end in `.gf`, for example `keyword.module.gf`, `keyword.judgement.gf`, `comment.block.gf`.
- `language-configuration.json` holds comment tokens (`--` for line comments, `{- -}` for block comments), brackets, auto-closing pairs, and indent/fold rules.
- `images/` holds the icon (`icon.png`, used as both the marketplace icon and the `.gf` file icon) and the README screenshots.

## Tests

- `npm test` runs the grammar assertion tests (`test/grammar/*.gf`) and the config/manifest checks (`test/config.test.mjs`, which uses `node:test`).
- `npm run test:snap` compares `test/snap/*.gf` against the committed `.snap` files. After an intentional scope change, regenerate them with `npm run test:snap -- --updateSnapshot` and review the diff.
- To run a single grammar file: `npx vscode-tmgrammar-test 'test/grammar/strings.gf'`.
- Grammar test files begin with `-- SYNTAX TEST "source.gf"`, and each `-- ^^^ scope` line asserts on the line above it. Negative assertions (`- scope`) match **exact** scope names, not prefixes, so write out the full scope. Indent source lines by at least 3 columns so the carets can reach column 0.
- `vscode-tmgrammar-test` also loads the grammar listed in `package.json`, which overrides `-g`. To test another grammar file, pass `--config` pointing at an empty JSON file.

## Development

- To try changes, open the repo in VS Code and press F5 (Run Extension). The Extension Development Host loads the extension from this folder, so any `.gf` file will do for testing. Use "Developer: Inspect Editor Tokens and Scopes" to check grammar scopes.
- To package or publish, use `npx @vscode/vsce package` / `vsce publish` (publisher `GrammaticalFramework`). `.vscodeignore` keeps tests and screenshots out of the VSIX.
- CI (`.github/workflows/ci.yml`) runs the tests, the snapshots and `vsce ls`.

## Conventions

- Log user-visible changes in `CHANGELOG.md` under `## Unreleased`. When releasing, move them under a new version heading and bump `version` in `package.json`.
- `language-configuration.json` patterns are compiled as JavaScript `RegExp` (no `(?x)` etc.), while grammar patterns are Oniguruma.
- GF identifiers may contain `'` and `_`. Keyword rules use `(?<![\w'])...(?![\w'])` instead of `\b`, and `'` must not auto-close.
- The tests check, among other things, that the current `version` has a `## x.y.z` heading in `CHANGELOG.md`.
- GF block comments are `{- ... -}`, not a dash run. Keep the grammar and `language-configuration.json` consistent on this.
