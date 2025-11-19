{ pkgs, pkgs-unstable, lib }:

with pkgs;

{
    codebase-to-text = python312Packages.callPackage ./tools/misc/codebase-to-text {};

    ctrld = callPackage ./servers/ctrld {};

    filen-cli = callPackage ./tools/networking/filen-cli {};

    gmpublisher = python312Packages.callPackage ./tools/games/gmpublisher {};
    gm-autorun-ng = callPackage ./tools/games/gm-autorun-ng {};

    mousejail = callPackage ./tools/X11/mousejail {};

    mount-wait = callPackage ./tools/misc/mount-wait {};
    mount-sshfs-run-service = callPackage ./tools/networking/mount-sshfs-run-service {};

    nixosTests = import ../nixos/tests/default.nix { inherit pkgs; };

    obs-studio-plugins = recurseIntoAttrs (callPackage ./applications/video/obs-studio/plugins { });

    rofi-adi1090x = callPackage applications/misc/rofi-adi1090x {};

    selkies-gstreamer = python311Packages.callPackage ./servers/selkies-gstreamer {
        gputil = ethorbit.python311.pkgs.gputil;
        basicauth = ethorbit.python311.pkgs.basicauth;
    };

    steam-acolyte = python312Packages.callPackage ./tools/games/steam-acolyte {};

    traefik-forward-auth = callPackage servers/traefik-forward-auth {};

    taggui = python312Packages.callPackage ./applications/editors/taggui {
        gptqmodel = ethorbit.python312.pkgs.gptqmodel;
    };

    vimPlugins = recurseIntoAttrs (callPackage ./applications/editors/vim/plugins { });

    xfce = recurseIntoAttrs (callPackage ./desktops/xfce { });

    yt-dlp-wrapper = pkgs-unstable.callPackage ./tools/misc/yt-dlp-wrapper {};
}
