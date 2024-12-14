# rill-nix

Nix [flake](https://nixos.wiki/wiki/Flakes) for [Rill](https://www.rilldata.com). BI as code

## Usage

This `rill` flake assumes you have already [installed Nix](https://determinate.systems/posts/determinate-nix-installer)

### Option 1. Use the `rill` CLI within your own flake

```nix
{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.rill.url = "github:rupurt/rill-nix";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rill,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rill.overlay
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.rill-pkgs.default
          ];
        };
      }
    );
}
```

The above config will add `rill` to your dev shell and also allow you to execute it
through the Nix CLI utilities.

```sh
# run from devshell
nix develop -c $SHELL
rill
```

### Option 2. Run the `rill` CLI directly with `nix run`

```nix
nix run github:rupurt/rill-nix
```

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`rill-nix` is released under the MIT license
