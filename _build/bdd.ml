open Formula
open Visited

module type BDD_Sig =
  sig
      type bdd

      val create : formula -> bdd
      (* Creates the canonical ROBDD associated with a formula *)

      val create_without_compression : formula -> bdd
      (* Creates a decision tree associated with formula, without any compression and memory sharing *)

      val satisfy : bdd -> bool* 'a list
      (* Tests the satisfiability of the formula. If it is satisfiable,
        also return the list of variables that are set to true (returns [] if
        not satisfiable)
      *)

      val print : bdd -> string -> unit
      (* Exports a .dot file representing the diagram *)
  end

module BDD : BDD_Sig =
   struct
  (* For now, BDD don't use compression *)
    type bdd =  Leaf of bool
              | Node of int * bdd * bdd

    let create f =
      let n = nb_var f in
      let v = Array.make n false in
      let ltrue = Leaf(true) and lfalse = Leaf(false) in
      let rec create_aux = function
        |i when (i > n) -> if (eval v f) then ltrue else lfalse
        |i ->  let l = create_aux (i+1) in
               let _ = (v.(i-1) <- true) in
               let h = create_aux (i+1) in
               let _ = (v.(i-1) <- false) in
                  Node(i,l,h)
      in create_aux 1;;

    let create_without_compression f =
      let n = nb_var f in
      let v = Array.make n false in
      let rec create_aux = function
        |i when (i > n) -> if (eval v f) then Leaf(true) else Leaf(false)
        |i ->  let l = create_aux (i+1) in
               let _ = (v.(i-1) <- true) in
               let h = create_aux (i+1) in
               let _ = (v.(i-1) <- false) in
                  Node(i,l,h)
      in create_aux 1;;

    let satisfy bdd = (true,[]) (* TO DO *)


    (*------ print auxilliary functions ------ *)

    let rec node_list = function
      |Leaf(x) -> []
      |Node(k,g,d) as x -> let l = node_list d in (x::node_list g)@l

    let get_id node l =
      let rec get_id_aux i = function
      |[] -> raise Not_found
      |t::q when t==node -> i
      |t::q -> get_id_aux (i+1) q
    in get_id_aux 1 l

    let print bdd name =
      let dot_file = open_out (name^".dot") in
        output_string dot_file "digraph BDD { \n size = \"2,2\"; \n";
        let ids = node_list bdd in
        let string_of_leaf b =
          if b then "True" else "False"
        in
        let string_of_node k id =
            "{"^(string_of_int id)^" [label = "^(string_of_int k)^"]}"
        in
        let to_string = function
          |Leaf(a) -> string_of_leaf a
          |Node(i,h,l) as x -> string_of_node i (get_id x ids)
        in
        let rec print_aux = function
          |Leaf(b) -> ()
          |Node(k,l,h) as x ->
                        output_string dot_file (to_string x);
                        output_string dot_file " -> ";
                        output_string dot_file (to_string l);
                        output_string dot_file " [style=dashed] ; \n";
                        output_string dot_file (to_string x);
                        output_string dot_file " -> ";
                        output_string dot_file (to_string h);
                        output_string dot_file " ; \n";
                        print_aux l;
                        print_aux h;
      in print_aux bdd;
      output_string dot_file "}" ;
      close_out dot_file;;

  end
