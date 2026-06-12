{ config, lib, pkgs, ... }:

let
    cfg = config.ethorbit.programs.selkies-gstreamer;
in
{
    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            libGL
            virtualgl
        ] ++ (
            if builtins.hasAttr xorg pkgs then [
                xorg.xrandr
                xorg.libxcvt
            ] else [
                xrandr
                libxcvt
            ]
        );
    };
}
