{
    rustPlatform,
    fetchFromGitHub,
    lib
}:

let
    version = "0.1.0";
in
    rustPlatform.buildRustPackage {
        pname = "autorun-ng";
        inherit version;

        src = fetchFromGitHub {
            owner = "vurvdev";
            repo = "Autorun-ng";
            rev = "aafb65d35f86f33e2b92636cd40d5beeaac7b36e";
            sha256 = "sha256-YFuwSLMpjQfgv1fphGNP2iykIKSZxV5Hy25DoBoHKFo=";
        };

        cargoLock = {
            lockFile = ./Cargo.lock;
            outputHashes = {
                "retour-0.4.0-alpha.4" = "sha256-uYshUNdvDqMvoP4Z72JDckEkxWfrMttFJqMJ3WAVUxI=";
            };
        };

        doCheck = false;

        postPatch = ''
            ln -s ${./Cargo.lock} Cargo.lock

              echo "Patching all crate roots..."
              for cargo in $(find . -name Cargo.toml); do
                dir=$(dirname "$cargo")
                for root in "$dir"/src/lib.rs "$dir"/src/main.rs; do
                  if [ -f "$root" ]; then
                    echo "  -> Adding feature(let_chains) to $root"
                    sed -i '1i #![feature(let_chains)]' "$root"
                  fi
                done
              done
        '';

        # Use nightly Rust
        RUSTC_BOOTSTRAP = "1";
        RUSTFLAGS = "--cfg=feature=\"let_chains\"";

        meta = with lib; {
            description = "A next-generation sandboxed GMod lua execution environment";
            homepage = "https://github.com/vurvdev/Autorun-ng";
            license = licenses.gpl3;
            platforms = platforms.linux ++ platforms.windows;
        };
    }
