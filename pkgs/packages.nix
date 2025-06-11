{ pkgs, lib }:

with pkgs;

{
    mousejail = callPackage ./mousejail {};
}
