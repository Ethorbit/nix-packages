{ config, pkgs, lib, ... }:

with lib;

let
    cfg = config.ethorbit.programs.termdown-wrapper;
in
{
    options = {
        ethorbit.programs.termdown-wrapper = {
            enable = mkOption {
                type = types.bool;
                description = "Whether or not to enable the wrapper for termdown";
                default = false;
            };

            soundPath = mkOption {
                type = types.str;
                description = "The sound file to play when the timer interval has finished.";
                default = "";
            };

            package = mkOption {
                type = types.package;
                default = pkgs.writeShellScriptBin "timer.sh" ''
                #!/usr/bin/env bash
                ${pkgs.termdown}/bin/termdown $(("$1")) && ${pkgs.vlc}/bin/cvlc -L "${cfg.soundPath}"
                '';
            };
        };
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ cfg.package ];
    };
}
