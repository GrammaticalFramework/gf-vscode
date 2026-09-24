-- SYNTAX TEST "source.gf" "module headers"

   abstract Foo = {
-- ^^^^^^^^ keyword.module.gf
--          ^^^ entity.name.type.module.gf
--              ^ keyword.operator.gf

   concrete FooEng of Foo = open Prelude in {
-- ^^^^^^^^ keyword.module.gf
--          ^^^^^^ entity.name.type.module.gf
--                 ^^ keyword.module.gf
--                    ^^^ entity.other.inherited-class.gf
--                          ^^^^ keyword.module.gf
--                                       ^^ keyword.other.gf

   incomplete resource Res_1' = Foo ** {
-- ^^^^^^^^^^ keyword.module.gf
--            ^^^^^^^^ keyword.module.gf
--                     ^^^^^ entity.name.type.module.gf
--                                  ^^ keyword.operator.gf

   instance DiffEng of DiffI = {
--          ^^^^^^^ entity.name.type.module.gf
--                     ^^^^^ entity.other.inherited-class.gf
