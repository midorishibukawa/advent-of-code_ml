(lang dune 3.8)

(name advent_of_code)

(generate_opam_files true)

(source
 (github midorishibukawa/advent-of-code_ml))

(authors "midori shibukawa")

(maintainers "midorishibukawa")

(license "GPL v3.0")

; (documentation https://url/to/documentation)

(package
 (name advent_of_code)
 (synopsis "my advent of code solutions")
 (description "my advent of code solutions")
 (depends ocaml core dune dream crunch ppx_inline_test)
 (tags
  (topics "advent of code")))


; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
