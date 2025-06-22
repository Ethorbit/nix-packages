{ pkgs }:

{
    selkies-gstreamer = import ./selkies-gstreamer.nix { inherit pkgs; };
    termdown-wrapper = import ./termdown-wrapper.nix { inherit pkgs; };
}
