(* open Expr *)

type boolexpr =
  Const of bool
  |Not of boolexpr
  |And of boolexpr * boolexpr
  |Or of boolexpr * boolexpr

module Boolexpr = struct

    type t = boolexpr

    let eval t env = true

    end
