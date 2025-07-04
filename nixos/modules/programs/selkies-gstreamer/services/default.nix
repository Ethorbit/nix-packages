{ config, lib, pkgs, ... }:

let
    cfg = config.ethorbit.programs.selkies-gstreamer;
in
{
    imports = [
        ./selkies-gstreamer.nix
        ./virtual-xserver.nix
        ./virtual-desktop.nix
    ];

    config = lib.mkIf cfg.enable {
        # Make sure pulseaudio's CPUWeight is increased to avoid audio lag
        systemd.user.services."pulseaudio".serviceConfig.CPUWeight = 500;

        # Selkies-Gstreamer will manage its own Virtual X server.
        # The issue is that display managers want to run THEIR own (non-virtual) X server,
        # so you cannot use this component and a display manager at the same time.

        services.displayManager = with lib; {
            sddm.enable = mkForce false;
        };

        services.xserver.displayManager = with lib; {
            startx.enable = mkForce true;
            lightdm.enable = mkForce false;

            # Set this instead to start your desired desktop experience.
            #sessionCommands = ''commands here'';
        };
    };
}
