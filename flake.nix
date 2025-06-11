{
    description = "Ethorbit's custom nixpkgs";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils, ... }:
        utils.lib.eachDefaultSystem (system:
            let
                overlay = final: prev: import ./pkgs/packages.nix {
                    pkgs = final;
                    lib = final.lib;
                };

                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [ overlay ];
                };

               packageSet = import ./pkgs/packages.nix {
                  pkgs = pkgs;
                  lib = pkgs.lib;
                };
            in {
                overlays.default = overlay;
                packages = packageSet;
            });
}
