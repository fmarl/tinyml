let loop () =
  while true do
    print_string "> ";
    flush stdout;

    let input = read_line () in
    print_endline ("Eval " ^ input)
  done
