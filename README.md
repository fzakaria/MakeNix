# MakeNix

This is a demonstratin of the power of _dynamic-derivations_ in Nix leveraged to build a C/C++ project via Makefile.

## Testing

You can run the parser by itself to generate the Nix expression that generates all the object files.

Afterwards you can build the nix expression to validate that it works.

```sh
# generate the .d files we need
> make 
# generate the nix expression
> go run parser/parser.go > test.nix
# test it!
> nix build -f test.nix --arg pkgs 'import <nixpkgs> {}'
```