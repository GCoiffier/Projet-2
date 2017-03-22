type programme =
     Const of int
    |Var of string
    |Let of programme
    |IfThenElse of programme * programme * programme
    |Add of programme * programme
