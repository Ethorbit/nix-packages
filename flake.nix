{
    description = "Collection of packages and NixOS modules by Ethorbit.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils, ... }:
        utils.lib.eachDefaultSystem (system:
            let
                overlay = final: prev: {
                    python3Packages = prev.python3Packages // 
                        (import ./pkgs/python-packages.nix {
                            pythonPackages = pkgs.python3Packages;
                        });

                    python311Packages = prev.python311Packages // 
                        (import ./pkgs/python-packages.nix {
                            pythonPackages = pkgs.python311Packages;
                        });

                    python312Packages = prev.python312Packages // 
                        (import ./pkgs/python-packages.nix {
                            pythonPackages = pkgs.python312Packages;
                        });
                } // import ./pkgs/packages.nix {
                    pkgs = final;
                    lib = final.lib;
                };

                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                    overlays = [ overlay ];
                };
            in {
                overlays.default = overlay;
                packages = pkgs;
            }
            ) // {
                nixosModules.default = import ./nixos/modules;
            };
}
