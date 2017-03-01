module Lookup =
  struct
    (* La structure utilisée sera une liste *)

    (* create : unit -> bdd list
      initializes a new object *)
    let create () = ref [];;

    (* mem : bdd -> bdd list -> bool
        checks if t is in the structure r. *)
    let mem t r = List.mem t (!r)

    (* find : bdd -> bdd list -> bdd
        checks if t is in the structure r. Is yes, t is returned.
        If not, t is added to the structure and returned *)
    exception Not_found

    let find t r =
      let rec aux = function
        | [] -> raise Not_found
        |a::q when (a = t) -> a
        |a::q -> aux q
      in aux !r;;

    (* add : bdd -> bdd list -> unit  *)
    let add t r = r := t::(!r)

  end;;
