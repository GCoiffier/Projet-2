open Fouine_type
open Dictionnaire

module Environnement =
    functor (D : Dictsig) ->
        (* Un environnement est défini pour toute structure de dictionnaire
            comprenant les primitives définies dans Dictsig *)
    struct

      type elt =
      (* Ce que l'on stocke dans l'environnement.
          C'est soit la valeur d'une variable,
          soit l'expression et la cloture associée à une fonction,
          soit une référence,
          soit un tableau *)
        | Int of int
        | Ref of int ref
        | Array of int array
        | Cloture of programme * (programme , elt) D.t

      let create n = D.create n

      let add = D.add
      let find = D.find
      let remove = D.remove
      let copy = D.copy
      let to_list = D.to_list

    end

module Env = Environnement(Dictionnaire)

let revers l=
	let rec aux l l_renv= match l with
		|[] -> l_renv
		|t::q -> aux q (t::l_renv) in
	aux l []
	
let rec transform_env env prg= match env with
	|[] -> prg
	|(Var(v), Env.Int(x))::q -> Let(Var(v), Const(x), transform_env q prg)
	|(Var(f), Env.Cloture(Pure(c),envf))::q -> LetRec(Var(f), c, transform_env q prg)
	|_::q -> transform_env q prg
	
