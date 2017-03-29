open Stack

type variable = string

module Cloture = Map.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)

module Environnement = Map.Make(struct
                   type t = variable
                   (* use Pervasives compare *)
                   let compare = compare
                  end)

module Env = struct
    (* Structure mutable de l'environnement *)
    let create () = ref (Environnement.empty)
    let find e x =

    let add e x v =

                    end
