
module type EnvSig = sig

    type ('a,'b) t
    val create : int -> ('a, 'b) t
    val add : ('a, 'b) t -> 'a -> 'b -> unit
    val remove : ('a, 'b) t -> 'a -> unit
    val find : ('a, 'b) t -> 'a -> 'b
    val copy : ('a, 'b) t -> ('a, 'b) t

end


module Env : EnvSig = struct

  type ('a, 'b) t = ('a, 'b) Hashtbl.t

  let create n = Hashtbl.create n

  let add t x y = Hashtbl.add t x y

  let remove t x = Hashtbl.remove t x

  let find t x = Hashtbl.find t x

  let copy t = Hashtbl.copy t

end
