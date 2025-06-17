# The application will say it can't connect until the dev
# comes back and fixes Linux compatibility
#
# That may never happen. \o/

{ callPackage, makeDesktopItem }:

let
    pname = "gmpublisher";
    gmpublisher = callPackage ./gmpublisher.nix {
        inherit pname;
    };
in
    makeDesktopItem {
        name = pname;
        desktopName = "gmpublisher";
        terminal = false;
        exec = "${gmpublisher}/bin/gmpublisher %f";
        icon = "${gmpublisher}/usr/share/icons/128x128.png";
    }
