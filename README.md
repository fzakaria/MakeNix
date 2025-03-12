# MakeNix

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