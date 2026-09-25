-- SYNTAX TEST "source.gf" "operators and punctuation"

   s = a ++ b ;
-- ^ - keyword.operator.gf
--   ^ keyword.operator.gf
--       ^^ keyword.operator.gf
--            ^ punctuation.separator.gf

   f : A -> B ;
--   ^ keyword.operator.gf
--       ^^ keyword.operator.gf

   t = table { Sg => x ; Pl => y } ! n ;
--                ^^ keyword.operator.gf
--                                 ^ keyword.operator.gf

   l = \x,y -> x.s ;
--     ^ keyword.operator.gf
--       ^ punctuation.separator.gf
--             ^ - keyword.operator.gf
--              ^ keyword.operator.gf

   r = x + y * z | w &+ v @ u ? t $ s # q - p ;
--       ^ keyword.operator.gf
--           ^ keyword.operator.gf
--               ^ keyword.operator.gf
--                   ^^ keyword.operator.gf
--                        ^ keyword.operator.gf
--                            ^ keyword.operator.gf
--                                ^ keyword.operator.gf
--                                    ^ keyword.operator.gf
--                                        ^ keyword.operator.gf

   c = case x of { _ => y } ;
--                 ^ variable.language.wildcard.gf
   d = x_y _z ;
--     ^^^^^^ - variable.language.wildcard.gf
