{ config, lib, pkgs, ... }:

let
    cfg = config.ethorbit.programs.selkies-gstreamer;
in
{
    config = lib.mkIf cfg.enable {
        i18n.inputMethod = {
            enabled = "fcitx5";
            fcitx5.addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
            ];
        };

        # NOTE: Joystick support won't exist until the Joystick Interposer
        # Gets added to the Selkies-Gstreamer package.
        systemd.tmpfiles.rules = [
            "d /dev/input 0755"
            "f /dev/input/js0"
            "f /dev/input/js1"
            "f /dev/input/js2"
            "f /dev/input/js3"
        ];
    };
}
