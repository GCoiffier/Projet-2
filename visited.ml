module VisitedBDD =
  struct
    (* La structure utilisée sera une liste *)

    (* create : unit -> bdd list
      initializes a new object *)
    let create () = ref [];;

    (* lookup : bdd -> bdd list -> bool
        checks if t is in the structure r.
        If not, t is added to the structure *)
    let lookup t r =
      let rec aux = function
        | [] -> let _ =  r := t::(!r) in false
        |a::q when (a == t) -> true
        |a::q -> aux q
      in aux !r;;
  end;;
