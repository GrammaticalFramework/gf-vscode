-- SYNTAX TEST "source.gf" "keywords"

   cat fun def data lincat lin lindef linref printname param oper flags
-- ^^^ keyword.judgement.gf
--     ^^^ keyword.judgement.gf
--         ^^^ keyword.judgement.gf
--             ^^^^ keyword.judgement.gf
--                  ^^^^^^ keyword.judgement.gf
--                         ^^^ keyword.judgement.gf
--                             ^^^^^^ keyword.judgement.gf
--                                    ^^^^^^ keyword.judgement.gf
--                                           ^^^^^^^^^ keyword.judgement.gf
--                                                     ^^^^^ keyword.judgement.gf
--                                                           ^^^^ keyword.judgement.gf
--                                                                ^^^^^ keyword.judgement.gf

   table pre case variants let in where pattern strs transfer
-- ^^^^^ keyword.other.gf
--       ^^^ keyword.other.gf
--           ^^^^ keyword.other.gf
--                ^^^^^^^^ keyword.other.gf
--                         ^^^ keyword.other.gf
--                             ^^ keyword.other.gf
--                                ^^^^^ keyword.other.gf
--                                      ^^^^^^^ keyword.other.gf
--                                              ^^^^ keyword.other.gf
--                                                   ^^^^^^^^ keyword.other.gf

   incomplete with open
-- ^^^^^^^^^^ keyword.module.gf
--            ^^^^ keyword.module.gf
--                 ^^^^ keyword.module.gf

-- regression: primes and underscores are identifier characters
   in' lin' case_ cat2 x'cat Str'
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ - keyword.module.gf keyword.judgement.gf keyword.other.gf
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ - support.type.gf support.constant.gf

-- keywords are case sensitive
   Lin Cat
-- ^^^^^^^ - keyword.module.gf keyword.judgement.gf keyword.other.gf
