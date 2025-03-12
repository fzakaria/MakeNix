# MakeNix

This is a demonstratin of the power of _dynamic-derivations_ in Nix leveraged to build a C/C++ project via Makefile.

```console
# enter a bind mount for the temporary store
> nix run nixpkgs#fish --store /tmp/dyn-drvs

> /nix/store/sqd5m6nyzcpf2pmc30yf2wzmncdf5giw-nix-2.27.0pre20250221_d904921/bin/nix build -f default.nix --store /tmp/dyn-drvs --print-out-paths -L
/nix/store/v4hkwn8y4m083gsap6523c0m5r985ygr-result

> ./result
Hello, World!
```

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