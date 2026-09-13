open Cmdliner
open Cmdliner.Term.Syntax

let tinyml_script filename = print_endline filename

let interactive =
  let doc = "Start a interactive TinyML session" in
  Arg.(value & flag & info ["i"; "interactive"] ~doc ~docv:"INTERACTIVE")

let script =
  let doc = "TinyML script to execute" in
  Arg.(value & pos 0 (some string) None & info [] ~docv:"SCRIPT" ~doc)

let tinyml_cmd =
  let doc = "TinyML Interpreter" in
  let man = [
    `S Manpage.s_bugs;
    `P "Email bug reports to <bugs@example.org>." ] in
  Cmd.make (Cmd.info "tinyml" ~version:"%%VERSION%%" ~doc ~man) @@ Term.ret @@
    let+ interactive and+ script in
    match interactive, script with
    | true, None -> `Ok (Tinyml.Repl.loop ())
    | false, Some filename -> `Ok (tinyml_script filename)
    | true, Some _ -> `Error (false, "-i cannot take a script")
    | false, None -> `Error (false, "a script is required in non-interactive mode")

let main () = Cmd.eval tinyml_cmd

let () = if !Sys.interactive then () else exit (main ())
