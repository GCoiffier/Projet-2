let f x = x in let f x= if x=0
		then 1
		else x*(f (x-1))
		 in let x= ref 0 in f 5;;
