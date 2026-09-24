-- SYNTAX TEST "source.gf" "strings"

   x = "plain" ;
--     ^^^^^^^ string.quoted.double.gf
--     ^ punctuation.definition.string.begin.gf
--           ^ punctuation.definition.string.end.gf
--             ^ punctuation.separator.gf
--             ^ - string.quoted.double.gf

-- regression: escaped quote must not end the string
   x = "a\"b" ; y
--       ^^ constant.character.escape.gf
--        ^^^ string.quoted.double.gf
--            ^ - string.quoted.double.gf
--            ^ punctuation.separator.gf
--              ^ - string.quoted.double.gf

   x = "back\\" ; z
--          ^^ constant.character.escape.gf
--             ^ - string.quoted.double.gf

-- comment markers inside strings are not comments
   x = "-- {- not a comment" ;
--      ^^^^^^^^^^^^^^^^^^^^ string.quoted.double.gf
--      ^^ - comment.line.double-dash.gf comment.block.gf
