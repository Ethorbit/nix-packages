{ pkgs, lib }:

with pkgs;

let
    cp = callPackage;
in
{
    mousejail = cp ./tools/X11/mousejail {};
    mount-wait = cp ./tools/misc/mount-wait {};
    mount-sshfs-run-service = cp ./tools/networking/mount-sshfs-run-service {};
    obs-studio-plugins.obs-pulseaudio-app-capture = cp ./applications/video/obs-studio/plugins/obs-pulseaudio-app-capture {};
    watch-xfce-xfconf = cp ./desktops/xfce/applications/watch-xfce-xfconf {};
    yt-dlp-wrapper = cp ./tools/misc/yt-dlp-wrapper {};
}
