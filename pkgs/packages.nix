{ pkgs, lib }:

with pkgs;

rec {
    codebase-to-text = python312Packages.callPackage ./tools/misc/codebase-to-text {};

    gmpublisher = python312Packages.callPackage ./tools/games/gmpublisher {};

    mousejail = callPackage ./tools/X11/mousejail {};

    mount-wait = callPackage ./tools/misc/mount-wait {};
    mount-sshfs-run-service = callPackage ./tools/networking/mount-sshfs-run-service {};

    obs-studio-plugins.obs-pulseaudio-app-capture = (
        callPackage ./applications/video/obs-studio/plugins/obs-pulseaudio-app-capture {}
    );

    selkies-gstreamer = python311Packages.callPackage ./servers/selkies-gstreamer {
        ethorbit.pythonPackages = ethorbit.python311Packages;
    };

    steam-acolyte = python312Packages.callPackage ./tools/games/steam-acolyte {};

    watch-xfce-xfconf = (
        python312Packages.callPackage ./desktops/xfce/applications/watch-xfce-xfconf {}
    );

    yt-dlp-wrapper = callPackage ./tools/misc/yt-dlp-wrapper {};
}
