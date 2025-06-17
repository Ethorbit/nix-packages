{
    pname,
    lib,
    fetchFromGitHub,
    fetchNpmDeps,
    rustPlatform,
    cargo-tauri,
    nodejs,
    npmHooks,
    pkg-config,
    wrapGAppsHook3,
    steam,
    openssl,
    glib-networking,
    libsoup,
    webkitgtk_4_0,
    curl
}:

let
    version = "2.11.0";

    description = ''
        Workshop Publishing Utility for Garry's Mod, 
        written in Rust & Svelte and powered by Tauri
    '';

    src = (fetchFromGitHub {
        owner = "WilliamVenner";
        repo = "gmpublisher";
        rev = "${version}";
        hash = "sha256-kasu86wanoYdXFzxECwho6Qcj9y6nuGRYnL/I/IUZVk=";
    });
in
    rustPlatform.buildRustPackage {
        inherit src pname description version;
        name = pname;

        buildType = "release";
        npmBuild = "npm run build";

        npmDeps = fetchNpmDeps {
            name = "${pname}-npm-deps-${version}";
            inherit src;
            hash = "sha256-VrCmluD93j6oBHYOWcYtyD1Qe8EBVf/yvZ/6j1L+QfA=";
        };

        cargoRoot = "src-tauri";
        cargoLock = {
            lockFile = "${src}/src-tauri/Cargo.lock";
        };
        cargoHash = "sha256-80njyllFItnVwXBsbuxjyZ0tuBDDC6XMIa6St5qe/eo=";

        buildAndTestSubdir = "src-tauri";

        nativeBuildInputs = [
            # Pull in our main hook
            cargo-tauri

            # Setup npm
            nodejs
            npmHooks.npmConfigHook

            # Make sure we can find our libraries
            pkg-config
            wrapGAppsHook3

            steam
        ];

        buildInputs = [
            openssl
            glib-networking # Most Tauri apps need networking
            libsoup
            webkitgtk_4_0
        ];

        postUnpack = ''
            echo "Contents of \$sourceRoot:"
            find $sourceRoot
        '';

        # Important libraries need to be loaded
        postInstall = ''
            mkdir -p $out/usr/share/icons
            mkdir -p $out/lib
            cp -r $src/src-tauri/icons/* $out/usr/share/icons/
            cp -r $src/src-tauri/lib/* $out/lib/
        '';

        preFixup = ''
            wrapProgram $out/bin/gmpublisher \
              --prefix LD_LIBRARY_PATH ":" \
              "${curl.out.outPath}/lib/libcurl.so:$LD_LIBRARY_PATH:$out/lib/steam_api/redistributable_bin/linux32:$out/lib/steam_api/redistributable_bin/linux64:$LD_LIBRARY_PATH"
        '';

        meta = {
            inherit description;
            homepage = "https://github.com/WilliamVenner/gmpublisher";
            license = lib.licenses.gpl3;
            platform = lib.platforms.linux;
        };
    }
