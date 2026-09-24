--# -path=.:../abstract:../common:prelude

{- A small abstract/concrete pair exercising most of the grammar.
   Block comments can span lines. -}

abstract Food = {
  flags startcat = Comment ;
  cat
    Comment ; Item ; Kind ; Quality ;
  fun
    Pred : Item -> Quality -> Comment ;
    This, That : Kind -> Item ;
    Very : Quality -> Quality ;
    Wine', Cheese : Kind ;
    Warm : Quality ;
}

concrete FoodEng of Food = open Prelude, (R = ResEng) in {
  lincat
    Comment, Quality = SS ;
    Kind = {s : Number => Str} ;
    Item = {s : Str ; n : Number} ;
  lin
    Pred item quality = ss (item.s ++ copula ! item.n ++ quality.s) ;
    This = det Sg "this" ;
    That = det Sg "that" ;
    Very q = ss ("very" ++ q.s) ;
    Wine' = regNoun "wine" ;
    Cheese = regNoun "cheese" ;
    Warm = ss "warm" ;
  param
    Number = Sg | Pl ;
  oper
    det : Number -> Str -> {s : Number => Str} -> {s : Str ; n : Number} =
      \n,d,cn -> {s = d ++ cn.s ! n ; n = n} ;
    regNoun : Str -> {s : Number => Str} = \w -> {s = table {Sg => w ; _ => w + "s"}} ;
    copula : Number => Str = table {Sg => "is" ; Pl => "are"} ;
    quote : Str = "say \"hi\"" ++ BIND ++ "!" ; -- escapes
    n2 : Int = 2 ;
    pl : Str -> Str = \x -> case x of {
      _ + "y" => init x + "ies" ;
      _ => pre {"a" | "e" => x ; _ => x + "s"}
    } ;
}
