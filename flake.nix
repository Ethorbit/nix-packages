{
    description = "Collection of packages and NixOS modules by Ethorbit.";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = {
        self,
        nixpkgs,
        nixpkgs-unstable,
        utils,
        ...
    }: {
        overlays = {
            default = final: prev: {
                ethorbit = {
                    python3 = final.python3 // {
                        pkgs = import ./pkgs/python-packages.nix { python = final.python3; };
                    };

                    python311 = final.python311 // {
                        pkgs = import ./pkgs/python-packages.nix { python = final.python311; };
                    };

                    python312 = final.python312 // {
                        pkgs = import ./pkgs/python-packages.nix { python = final.python312; };
                    };
                } // import ./pkgs/packages.nix {
                    pkgs = final;
                    pkgs-unstable = import nixpkgs-unstable {
                        system = final.system;
                        config.allowUnfree = true;
                    };
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
