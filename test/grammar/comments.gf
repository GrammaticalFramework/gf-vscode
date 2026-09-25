-- SYNTAX TEST "source.gf" "comments"

   x = y ; -- trailing comment
--         ^^^^^^^^^^^^^^^^^^^ comment.line.double-dash.gf
--         ^^ punctuation.definition.comment.gf
--     ^ - comment.line.double-dash.gf comment.block.gf

-- regression: comment wins over operators
   a --> b
--   ^^^^^ comment.line.double-dash.gf
   a --+ b
--   ^^^^^ comment.line.double-dash.gf

   {- block -- with dash "and quote -} x
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.block.gf
-- ^^ punctuation.definition.comment.begin.gf
--                                  ^^ punctuation.definition.comment.end.gf
--                                     ^ - comment.line.double-dash.gf comment.block.gf

   {- multi
      line -} lin
-- ^^^^^^^^^^ comment.block.gf
--            ^^^ keyword.judgement.gf

   --# -path=.:../prelude
-- ^^^^^^^^^^^^^^^^^^^^^^ meta.preprocessor.gf
-- ^^^ - comment.line.double-dash.gf comment.block.gf
