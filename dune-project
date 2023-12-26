(lang dune 3.12)

(name advent_of_code)

(generate_opam_files true)

(source
 (github midorishibukawa/advent-of-code_ml))

(authors "midori shibukawa")

(maintainers "midorishibukawa")

(license "GPL-3.0-or-later")

; (documentation https://url/to/documentation)

(package
 (name advent_of_code)
 (synopsis "My advent of code solutions")
 (description "my advent of code solutions")
 (depends 
   batteries 
   crunch 
   dream
   dream-html
   dune 
   ocaml 
   ppx_inline_test)
 (tags
  (topics "advent of code")))


; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
