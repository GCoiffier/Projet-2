open Formula
open Visited
open Bddsig
open Valuation

module BDD : BDD_Sig =
   struct
    type bdd =  Leaf of bool
              | Node of int * bdd * bdd

    let create f =
      let ltrue = Leaf(true) and lfalse = Leaf(false) in
      let visited = Lookup.create () in
      let rec create_aux v = function
         [] -> if (eval v f) then ltrue else lfalse
        |t::q -> let l = create_aux (Valuation.add t false v) q in
                let h = create_aux (Valuation.add t true (Valuation.remove t v)) q in
                 let node = if (l=h) then l else Node(t,l,h) in
                    if (Lookup.mem node visited) then (Lookup.find node visited)
                      else (Lookup.add node visited; node)
      in create_aux (Valuation.empty) (get_variables f);;


    let rec satisfy bdd v = match bdd with
        |Leaf(x) -> x
        |Node(i,l,h) -> if (Valuation.find i v) then (satisfy h v) else (satisfy l v)


    let size bdd =
      let visited = Lookup.create () in
      let rec nb_node_aux = function
         |Leaf(x) -> 0
         |Node(k,l,h) as x when (not (Lookup.mem x visited))-> let _ = Lookup.add x visited in 1 + (nb_node_aux l) + (nb_node_aux h)
         |x -> 0
      in (2 + nb_node_aux bdd) (* 2 for true and false leaves *)


      let node_list bdd =
        (* La liste des noeuds d'un BDD *)
        let visited = Lookup.create() in
        let rec node_list_aux = function
          |Leaf(x) -> ()
          |Node(k,g,d) as x when (not (Lookup.mem x visited )) -> Lookup.add x visited;
                                                                      node_list_aux g;
                                                                      node_list_aux d
          |Node(k,g,d) -> node_list_aux g;
                          node_list_aux d
        in let _ = node_list_aux bdd in (Lookup.tolist visited)


    let get_id node l =
      (*  Indice dans une liste. Permet d'associer un entier à chaque noeud. Fonction auxilliaire de print *)
      let rec get_id_aux i = function
      |[] -> raise Not_found
      |t::q when t==node -> i
      |t::q -> get_id_aux (i+1) q
    in get_id_aux 1 l


    let print bdd name =
      let dot_file = open_out (name^".dot") in
        output_string dot_file "digraph BDD { \n size = \"2,2\"; \n";
        let ids = node_list bdd in
        let seen = ref [] in
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
        let edge_to_string a b t =
          if not (List.mem (a,b) (!seen)) then
          begin
            seen := (a,b)::(!seen);
            output_string dot_file (to_string a);
            output_string dot_file " -> ";
            output_string dot_file (to_string b);
            if (not t) then (output_string dot_file " [style=dashed]") else ();
              output_string dot_file " ;\n"
          end
        in
        let rec print_aux = function
          |Leaf(b) -> ()
          |Node(k,l,h) as x ->
                        edge_to_string x l false;
                        edge_to_string x h true;
                        print_aux l;
                        print_aux h;
      in (match bdd with
        Leaf(x) -> output_string dot_file ((string_of_leaf x)^";"); (* cas où le BDD est réduit à une feuille -> formule non satifiable ou tautologie *)
        |bdd -> print_aux bdd);
      output_string dot_file "}" ;
      close_out dot_file;;

    let print_as_string bdd =
      let rec to_string = function
        |Leaf(x) -> if x then "Leaf(True)" else "Leaf(False)"
        |Node(i,l,h) -> "Node("^(string_of_int i)^","^(to_string l)^","^(to_string h)^")"
      in print_string (to_string bdd); print_newline ();;

  end
