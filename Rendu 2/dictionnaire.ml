module type Dictsig = sig

    type ('a,'b) t
    val create : int -> ('a, 'b) t
    val add : ('a, 'b) t -> 'a -> 'b -> unit
    val remove : ('a, 'b) t -> 'a -> unit
    val find : ('a, 'b) t -> 'a -> 'b
    val copy : ('a, 'b) t -> ('a, 'b) t

end


module Dictionnaire : Dictsig = struct
  (* Le dictionnaire est implémenté à l'aide d'une table de hachage *)

  type ('a, 'b) t = ('a, 'b) Hashtbl.t

  let create n = Hashtbl.create n
  let add = Hashtbl.add
  let remove = Hashtbl.remove
  let find = Hashtbl.find
  let copy = Hashtbl.copy

end
