-- SYNTAX TEST "source.gf" "literals and builtins"

   n = 42 ; f = 3.14 ; g = 1.0e10 ;
--     ^^ constant.numeric.gf
--              ^^^^ constant.numeric.gf
--                         ^^^^^^ constant.numeric.gf

-- regression: digits inside identifiers are not numbers
   N2 V2V x1'
-- ^^^^^^^^^^ - constant.numeric.gf

   oper f : Str -> Strs -> Type -> PType -> Tok -> Int -> Float -> String ;
--          ^^^ support.type.gf
--                 ^^^^ support.type.gf
--                         ^^^^ support.type.gf
--                                 ^^^^^ support.type.gf
--                                          ^^^ support.type.gf
--                                                 ^^^ support.type.gf
--                                                        ^^^^^ support.type.gf
--                                                                 ^^^^^^ support.type.gf

   s = x ++ BIND ++ SOFT_BIND ++ SOFT_SPACE ++ CAPIT ++ ALL_CAPIT ++ nonExist ;
--          ^^^^ support.constant.gf
--                  ^^^^^^^^^ support.constant.gf
--                               ^^^^^^^^^^ support.constant.gf
--                                             ^^^^^ support.constant.gf
--                                                      ^^^^^^^^^ support.constant.gf
--                                                                   ^^^^^^^^ support.constant.gf
