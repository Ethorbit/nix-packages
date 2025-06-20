{ config, lib, ... }:

let
    cfg = config.programs.selkies-gstreamer;
in
{
    config = lib.mkIf cfg.enable {
        systemd.tmpfiles.rules = [
          "f /var/lib/systemd/linger/${cfg.settings.user}"
          #"d /etc/opt/VirtualGL 750 root vglusers -"
        ];
        #users.groups.vglusers = {};

        users.users."${cfg.settings.user}" = {
            # we enable linger so that a logon is not necessary for selkies gstreamer to start
            linger = true;

            extraGroups = [ "input" ]; # "vglusers"
        };
    };
}
