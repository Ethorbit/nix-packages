{ config, pkgs, lib, ... }:

let
    cfg = config.ethorbit.programs.selkies-gstreamer;
in
{
    config = lib.mkIf cfg.enable {
        systemd.user.services."virtual-xserver" = {
            enable = true;
            description = "Systemd + nix port of nvidia-egl-docker's 'entrypoint' supervisor service, the part that starts the X server";
            environment = config.environment.variables;
            before = [ "virtual-desktop.service" ];

            serviceConfig = {
                Type = "simple";
                Restart = "always";
                RestartSec = 5;
                CPUWeight = 500;
            };

            script = ''
                "${cfg.services.userValidationScript}/bin/script" || exit 0

                # Run Xvfb server and its commands with required extensions
                ${pkgs.xorg.xvfb}/bin/Xvfb "''${DISPLAY}" -ac -screen "0" "8192x4096x''${DISPLAY_CDEPTH}" -dpi "''${DISPLAY_DPI}" +extension "COMPOSITE" +extension "DAMAGE" +extension "GLX" +extension "RANDR" +extension "RENDER" +extension "MIT-SHM" +extension "XFIXES" +extension "XTEST" +iglx +render -nolisten "tcp" -noreset -shmem
            '';

            wantedBy = [ "default.target" ];
        };
    };
}
