{ fetchzip, callPackage }:

let
    hammer = callPackage ./hammerplusplus.nix {};
in
{
    gmod = hammer {
        game-name = "gmod";
        src = fetchzip {
            url = "https://github.com/ficool2/HammerPlusPlus-Website/releases/download/8870/hammerplusplus_gmod_build8870.zip";
            hash = "sha256-zeki2qwuegqahTHYBDwgeByw0UyBoaYtzOKH0SGnI0I=";
            stripRoot = false;
        };
    };
}
