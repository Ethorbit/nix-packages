Reusable nix packages and NixOS modules by yours truly

Importing:
```nix
inputs = {
    nixpkgs.url = "whatever";
    ethorbit = {
        url = "github:ethorbit/nix-packages";
        inputs.nixpkgs.follows = "nixpkgs";
    };
};

outputs = { nixpkgs, ethorbit, ... }: {
    nixosConfigurations.<host> = nixpkgs.lib.nixosSystem {
        nixpkgs.overlays = [
            ethorbit.overlays.default
        ];

        modules = [
            ethorbit.nixosModules.default

            ./configuration.nix
        ];
    };
};
```

Installing a package:
```nix
environment.systemPackages = [ ethorbit.pkg-name ];
```
