let rec fact n =
    if (n<=1) then n
             else n*(fact (n-1))
in fact 6;;
