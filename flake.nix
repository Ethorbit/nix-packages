{
    description = "Collection of packages and NixOS modules by Ethorbit.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils, ... }: {
        overlays = {
            default = final: prev: {
                ethorbit = {
                    python3Packages = import ./pkgs/python-packages.nix {
                        pythonPackages = final.python3Packages;
                    };

                    python311Packages = import ./pkgs/python-packages.nix {
                        pythonPackages = final.python311Packages;
                    };

                    python312Packages = import ./pkgs/python-packages.nix {
                        pythonPackages = final.python312Packages;
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
