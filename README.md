# MakeNix

## Testing

You can run the parser by itself to generate the Nix expression that generates all the object files.

Afterwards you can build the nix expression to validate that it works.

```sh
> go run parser/parser.go > test.nix
> nix build -f test.nix --arg pkgs 'import <nixpkgs> {}'
```