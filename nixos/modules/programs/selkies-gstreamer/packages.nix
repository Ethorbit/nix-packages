{ config, lib, pkgs, ... }:

let
    cfg = config.ethorbit.programs.selkies-gstreamer;
in
{
    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            xorg.xrandr
            xorg.libxcvt
            libGL
            virtualgl
        ];
    };
}
