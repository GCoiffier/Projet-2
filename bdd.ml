open Formula

(* For now, we have BDT : Binary decision tree *)

module type BDD_Sig =
  sig
      type bdd

      val create : formula -> bdd
      (* Creates the canonical BDD associated with a formula *)

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
  (* For now, BDD don't use compression -> a binary tree with height n *)
    type bdd =  Leaf of bool
              | Node of int * bdd * bdd

    let create f =
      let n = nb_var f in
      let v = Array.make n false in
      let ltrue = Leaf(true) and lfalse = Leaf(false) in
      let rec build_aux f i = match (abs i) with
        |x when ((abs x) = n) -> Leaf(eval v f)
        |x -> let g = build_aux f (-(x+1)) in
                let _ = (v.(x-1) <- true) in
                let d = build_aux f (x+1) in
                let _ = (v.(x-1) <- false) in
                Node(i,g,d)
      in build_aux f 1;;

    let satisfy bdd = (true,[]) (* TO DO *)

    let print bdd name =
      let dot_file = open_out (name^".dot") in
        output_string dot_file "digraph BDD { \n size = \"2,2\"; \n";
        let i = ref 0 in
        let s k = if k>=0 then string_of_int k else "NOT_"^(string_of_int (-k)) in
        let string_of_leaf b =
        let _ = incr i in
          if b then "{ l"^(s !i)^"[label = \"True \"]}" else "{ l"^(s !i)^"[label = \"False \"]}"
        in
        let rec print_aux = function
          |Leaf(b) -> ()
          |Node(k,l,h) -> match (l,h) with
              Leaf(a),Leaf(b) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " [style=dashed] ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf b);
                         output_string dot_file " ; \n";
              |(Node(x,_,_), Leaf(a)) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (s x);
                         output_string dot_file " [style=dashed] ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " ; \n";
                         print_aux l;
              |(Leaf(a), Node(x,_,_)) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (s x);
                         output_string dot_file " [style=dashed] ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " ; \n";
                         print_aux h;
             |(Node(x,_,_), Node(y,_,_)) ->
                        output_string dot_file (s k);
                        output_string dot_file " -> ";
                        output_string dot_file (s x);
                        output_string dot_file " [style=dashed] ; \n";
                        output_string dot_file (s k);
                        output_string dot_file " -> ";
                        output_string dot_file (s y);
                        output_string dot_file " ; \n";
                        print_aux l;
                        print_aux h;
      in print_aux bdd;
      output_string dot_file "}" ;
      close_out dot_file;;

  end
