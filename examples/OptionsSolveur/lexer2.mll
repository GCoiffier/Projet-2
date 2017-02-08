{
open Parser2;;        
exception Eof;;
}

rule token = parse    (* la "fonction" aussi s'appelle token .. *)
  | [' ' '\t']     { token lexbuf }    (* on saute les blancs *)
  | '\n'            { EOL }
  | ['0'-'9']+ as s { INT (int_of_string s) }
  | eof             { raise Eof } 
