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

let transform_env env prg=
	let rec aux env prg= match env with
		|[] -> prg
		|(Var(v), Env.Int(x))::q -> Let(Var(v), Const(x), aux q prg)
		|(Var(f), Env.Cloture(Pure(c),envf))::q -> ( try (match Env.find envf (Var(f)) with
				| Env.Cloture(Pure(c_),_) when c_=c -> LetRec(Var(f), c, aux q prg)
				| _ 								-> Let(Var(f), c, aux q prg)
				) with  _ -> (Let(Var(f), c, aux q prg)))
		|_::q ->aux q prg in
				aux (Env.to_list (Env.copy env)) prg
