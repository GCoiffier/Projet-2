
module VisitedNodes = functor (E : EqualType) ->
  struct
    type 'a elt = 'a E.elt
    type 'a t = 'a elt list ref (* La structure utilisée sera une liste *)

    (* create : unit -> 'a t
      initializes a new object *)
    let create () = ref [];;

    (* lookup : 'a elt -> 'a t -> bool
        checks if t is in the structure r.
        If not, t is added to the structure *)
    let lookup t r =
      let rec aux = function
        | [] -> let _ =  r := t::(!r) in false
        |a::q when (E.equal a t) -> true
        |a::q -> aux q
      in aux !r;;

    (* tolist : 'a t -> 'a elt list *)
    let tolist t = !t
  end;;


module type Visited_Sig =
  sig
    type t
    val create : unit -> t
    val lookup : t ->
  end

module Visited : Visited_Sig ->
  struct
    type 'a elt = 'a E.elt
    type t =  int list ref (* La structure utilisée sera une liste *)

    (* create : unit -> 'a t
      initializes a new object *)
    let create () = ref [];;

    (* lookup : 'a elt -> 'a t -> bool
        checks if t is in the structure r.
        If not, t is added to the structure *)
    let lookup t r =
      let rec aux = function
        | [] -> let _ =  r := t::(!r) in false
        |a::q when (E.equal a t) -> true
        |a::q -> aux q
      in aux !r;;

    (* tolist : 'a t -> 'a elt list *)
    let tolist t = !t
  end;;
