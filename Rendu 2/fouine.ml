type programme =
     Const of int
    |Var of string
    |Let of programme
    |Add of programme * programme
