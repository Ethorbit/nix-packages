{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
    pname = "gdshader-language-server";
    version = "v0.6.0";

    src = fetchFromGitHub {
        owner = "armsnyder";
        repo = "gdshader-language-server";
        rev = "3f79ab8a7eb6caf6dc5abf258158e80d29485159";
        sha256 = "sha256-t+1hXDH6bAxQo5O2y+SndSI+6z5aSAO2sx23DbNYiGY=";
    };

    vendorHash = "sha256-eaomuuBDRasmVcApVzP2y/WSNLp3KmWBNmHDZWm4LW0=";

    meta = {
        description = ''
        External editor support for .gdshader files
        '';
        homepage = "https://github.com/${src.owner}/${src.repo}";
        license = lib.licenses.mit;
        platforms = lib.platforms.linux;
    };
}
