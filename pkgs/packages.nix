{ pkgs, lib }:

with pkgs;

{
    yt-dlp-wrapper = callPackage ./wrappers/yt-dlp {};
    mousejail = callPackage ./tools/X11/mousejail {};
}
