{ pkgs, lib }:

with pkgs;

let
    cp = callPackage;
in
{
    mousejail = cp ./tools/X11/mousejail {};
    mount-wait = cp ./tools/misc/mount-wait {};
    mount-sshfs-run-service = cp ./tools/networking/mount-sshfs-run-service {};
    yt-dlp-wrapper = cp ./tools/misc/yt-dlp-wrapper {};
}
