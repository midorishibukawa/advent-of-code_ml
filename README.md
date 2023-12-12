# moved to gilab

as of december 12th 2023, this repository has been moved to [gitlab](https://gitlab.com/midorishibukawa/advent-of-code_ml).

# advent of code (ocaml)

hello! these are my [advent of code](https://adventofcode.com) solutions in ocaml.

this (2023) is my first year participating in the challenge while it's still ongoing (and I'm already a day late!), but I do intend to implement solutions for past years challenges when possible.

you can find my solutions in the [lib](lib/) directory, grouped by year, or by clicking on the links at the bottom of this README. 

## running the web server

the [bin](bin/) directory also provides a simple https web server written using [dream](https://aantron.github.io/dream/) and [htmx](https://htmx.org/).

in order to run the server, you'll first need to install its dependencies. if you're using the [nix](https://nixos.org/) package manager, the `flake.nix` provided (credits to [opam-nix](https://github.com/tweag/opam-nix)) will setup everything for you by simply running the following command:

```
nix develop
```

otherwise, you'll need both [dune](https://dune.build/) and [opam](https://opam.ocaml.org/) installed on your system, as well as the following opam packages:

```
ocaml batteries dune dream crunch ppx_inline_test
```

once you've got everything you need, you can start the web server by using the following commands:

```
dune build && dune exec advent_of_code
```

alternatively, you can build and run on watch mode with the following command:

```
dune build -w @run
```

the web server is set up to listen on `https://localhost:8080`

## Y23:

| SUN | MON | TUE | WED | THU | FRI | SAT |
|-----|-----|-----|-----|-----|-----|-----|
|     |     |     |     |     |[01★★](lib/y23/day01.ml)|[02★★](lib/y23/day02.ml)|
|[03★★](lib/y23/day03.ml)|[04★☆](lib/y23/day04.ml)| 05☆☆| 06☆☆| 07☆☆| 08☆☆| 09☆☆|
| 10☆☆| 11☆☆| 12☆☆| 13☆☆| 14☆☆| 15☆☆| 16☆☆|
| 17☆☆| 18☆☆| 19☆☆| 20☆☆| 21☆☆| 22☆☆| 23☆☆|
| 24☆☆| 25☆☆|     |     |     |     |     |
