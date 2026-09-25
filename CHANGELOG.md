# Change Log

## 2.1.0
- Add file icon for `.gf` files
- Highlighting fixes:
  - Escaped characters in strings (`"a\"b"`) no longer end the string early
  - Keywords are no longer highlighted inside identifiers with primes, e.g. `lin'`
  - Comments now always take precedence over operators (`-->`)
  - Removed an empty `firstLineMatch` that matched every file
- New highlighting:
  - `--#` pragmas
  - Module names in headers (`concrete FooEng of Foo`)
  - Built-in types (`Str`, `Type`, `Int`, …) and tokens (`BIND`, `SOFT_BIND`, …)
  - Numbers, the `_` wildcard, and the keywords `pattern`, `strs` and `transfer`
  - More operators: `++`, `**`, `&+`, `@`, `?`, `$`, `#`, `<`, `>`, `-`
- Operators and separators now use standard scopes (`keyword.operator`, `punctuation.separator`) instead of `constant`, so their colours follow your theme's conventions
- Editor behaviour:
  - Indentation rules now take effect (they were previously ignored)
  - `<` and `'` no longer auto-close, so `->`, `=>` and primed identifiers like `x'` are no longer disrupted and no longer break bracket pair colourisation
  - `[` `]` are treated as brackets
  - `"` no longer auto-closes inside strings and comments
  - Double-click selects whole identifiers including `'` and `_`
- Require VS Code 1.64 or newer (needed for the file icon)
- Add grammar and configuration tests

## 2.0.1
- Update icon
- Add screenshots to README

## 2.0.0
- Fix grammar
- Add icon

## 1.3.0
- Fixed block comments (they are `{- ... -}` and not just dashes)

## 1.2.0
- Updated `language-configuration.json` and README

## 1.0.0
- Initial release
