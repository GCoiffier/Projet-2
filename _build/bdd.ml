open Formula

module type BDD_Sig =
  sig
      type bdd
      val build_from_formula : formula -> bdd
      val satisfy : bdd -> bool* 'a list
      val print : bdd -> string -> unit
  end

module BDD : BDD_Sig =
  struct
  (* For now, BDD don't use compression -> a binary tree with height n *)
    type bdd =  Leaf of bool
              | Node of int * bdd * bdd

    let build_from_formula f = Node(1,Node(2,Leaf(true),Leaf(false)), Leaf(true))
    (*  let v = Array.make
      |Const *)

    let satisfy bdd = (true,[])

    let print bdd name =
      let dot_file = open_out (name^".dot") in
        output_string dot_file "digraph BDD { \n size = \"2,2\"; \n";
        let i = ref 0 in
        let s = string_of_int in
        let string_of_leaf b =
        let _ = incr i in
          if b then "{ l"^(s !i)^"[label = \"True \"]}" else "{ l"^(s !i)^"[label = \"False \"]}"
        in
        let rec print_aux = function
          |Leaf(b) -> ()
          |Node(k,g,d) -> match (g,d) with
              Leaf(a),Leaf(b) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf b);
                         output_string dot_file " ; \n";
              |(Node(x,_,_), Leaf(a)) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (s x);
                         output_string dot_file " ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " ; \n";
                         print_aux g;
              |(Leaf(a), Node(x,_,_)) ->
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (s x);
                         output_string dot_file " ; \n";
                         output_string dot_file (s k);
                         output_string dot_file " -> ";
                         output_string dot_file (string_of_leaf a);
                         output_string dot_file " ; \n";
                         print_aux d;
             |(Node(x,_,_), Node(y,_,_)) ->
                        output_string dot_file (s k);
                        output_string dot_file " -> ";
                        output_string dot_file (s x);
                        output_string dot_file " ; \n";
                        output_string dot_file (s k);
                        output_string dot_file " -> ";
                        output_string dot_file (s y);
                        output_string dot_file " ; \n";
                        print_aux g;
                        print_aux d;
      in print_aux bdd;
      output_string dot_file "}" ;
      close_out dot_file;;

  end
