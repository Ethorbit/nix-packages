{
    lib,
    stdenv,
    fetchurl,
    makeDesktopItem,
    copyDesktopItems,
    makeWrapper,
    wine,
    wine64
}:

{ game-name, src }:

let
    wineArch = if stdenv.hostPlatform.is64bit then "win64" else "win32";
in
    stdenv.mkDerivation rec {
        inherit src;

        name = "hammerplusplus-${game-name}";

        nativeBuildInputs = [
            copyDesktopItems
            makeWrapper
        ];

        nativeRuntimeInputs = [
            wine
            wine64
        ];

        icon = fetchurl {
            url = ''
            https://developer.valvesoftware.com/w/images/thumb/c/cd/Hammerplusplus_splash.png/300px-Hammerplusplus_splash.png
            '';
            hash = "sha256-hlPFM7//wm/Q52XzlwKelEvISVRFERFu5aa9RQBk+H4=";
        };

        installPhase = ''
            runHook preInstall

            mkdir -p $out/bin
            mkdir -p $out/share/lib/hammerplusplus
            mkdir -p $out/share/icons/hicolor/256x256/apps

            cp -r ${src}/hammerplusplus_gmod_build8870/bin/win64/hammerplusplus/* \
                $out/share/lib/hammerplusplus/

            # Wrap the executable
            PATH_BIN=${lib.makeBinPath nativeRuntimeInputs};
            substitute ${./script.sh} $out/bin/hammerplusplus \
                --replace-fail "@out@" "$out" \
                --replace-fail "@path@" "$PATH_BIN" \
                --replace-fail "@wineArch@" "${wineArch}"

            chmod +x $out/bin/hammerplusplus

            cp ${icon} $out/share/icons/hicolor/256x256/apps/hammerplusplus.png

            runHook postInstall
        '';

        desktopItems = [
            (makeDesktopItem {
                name = "HammerPlusPlus-${game-name}";
                desktopName = "Hammer++ (${game-name})";
                exec = "hammerplusplus %f";
                icon = "hammerplusplus";
                terminal = false;
                categories = [ "Development" "Game" "Graphics" ];
                mimeTypes = [ "text/x-vmf" ];
            })
        ];

        meta = {
            description = ''
            Hammer++ is a free, extensive modification of Valve's Hammer editor for the Source engine, 
            with the premise of being a more stable, up-to-date version, with many bugfixes and several 
            improvements present in modern level editors.
            '';
            homepage = "https://ficool2.github.io/HammerPlusPlus-Website/index.html";
            license = lib.licenses.unfree;
            platforms = wine.meta.platforms;
        };
    }
