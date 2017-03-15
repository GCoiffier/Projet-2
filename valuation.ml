module Valuation = Map.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)


module Var = Set.Make(struct
                       type t = int
                       (* use Pervasives compare *)
                       let compare = compare
                      end)
