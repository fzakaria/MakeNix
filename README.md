# MakeNix

> Checkout my blog post [https://fzakaria.com/2025/03/11/nix-dynamic-derivations-a-practical-application](https://fzakaria.com/2025/03/11/nix-dynamic-derivations-a-practical-application) for an overview on this example.

This is a demonstratin of the power of _dynamic-derivations_ in Nix leveraged to build a C/C++ project via Makefile.

⚠️ As of _2025-03-11_, you need to use [nix@d904921](https://github.com/NixOS/nix/commit/d904921eecbc17662fef67e8162bd3c7d1a54ce0) in order to use _dynamic-derivations_. Additionally, you need to enable `experimental-features = ["nix-command" "dynamic-derivations" "ca-derivations" "recursive-nix"]`. Here, there be dragons 🐲.

```console
# let's do everything in /tmp/dyn-drvs as a temporary
# nix store.
# 
# enter a bind mount for the temporary store
> nix run nixpkgs#fish --store /tmp/dyn-drvs

> nix build -f default.nix --store /tmp/dyn-drvs --print-out-paths -L
/nix/store/v4hkwn8y4m083gsap6523c0m5r985ygr-result

> ./result
Hello, World!
```

Check out [NpmNix](https://github.com/fzakaria/NpmNix) for an example of how you might apply _dynamic-derivations_ for `lang2nix` style tooling.

## Testing

You can run the parser by itself to generate the Nix expression that generates all the object files.

Afterwards you can build the nix expression to validate that it works.

```sh
# generate the .d files we need
> make deps
# generate the nix expression
> go run parser/parser.go > test.nix
# test it!
> nix build -f test.nix --arg pkgs 'import <nixpkgs> {}'
```
