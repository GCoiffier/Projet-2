open Stack

module Cloture = Map.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)

module Environnement = Map.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)