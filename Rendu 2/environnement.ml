open Prog_type

module type Dictsig = sig

    type ('a,'b) t
    val create : int -> ('a, 'b) t
    val add : ('a, 'b) t -> 'a -> 'b -> unit
    val remove : ('a, 'b) t -> 'a -> unit
    val find : ('a, 'b) t -> 'a -> 'b
    val copy : ('a, 'b) t -> ('a, 'b) t

end


module Dictionnaire : Dictsig = struct

  type ('a, 'b) t = ('a, 'b) Hashtbl.t

  let create n = Hashtbl.create n
  let add = Hashtbl.add
  let remove = Hashtbl.remove
  let find = Hashtbl.find
  let copy = Hashtbl.copy

end

module Environnement =
    functor (D : Dictsig) ->
    struct

        (* Ce que l'on stocke dans l'environnement.
        C'est soit la valeur d'une variable, soit
        l'expression et la cloture associée à une fonction *)
      type elt =
        | Int of int
        | Ref of int
        | Cloture of programme * (programme , elt) D.t

      let create n = D.create n

      let add = D.add
      let find = D.find
      let remove = D.remove
      let copy = D.copy

    end

module Env = Environnement(Dictionnaire)
