{
    description = "Collection of packages and NixOS modules by Ethorbit.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils, ... }: {
        overlays = {
            default = final: prev: {
                ethorbit = {
                    python3Packages = import ./pkgs/python-packages.nix {
                        python = final.python3;
                    };

                    python311Packages = import ./pkgs/python-packages.nix {
                        python = final.python311;
                    };

                    python312Packages = import ./pkgs/python-packages.nix {
                        python = final.python312;
                    };
                } // import ./pkgs/packages.nix {
                    pkgs = final;
                    lib = final.lib;
                };
            };
        };

        nixosModules.default = import ./nixos/modules;

        packages = utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                    overlays = [ self.overlays.default ];
                };
            in {
                default = pkgs.ethorbit;
            }
        );
    };
}
