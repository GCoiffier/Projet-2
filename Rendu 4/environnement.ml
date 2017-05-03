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

    end

module Env = Environnement(Dictionnaire)
