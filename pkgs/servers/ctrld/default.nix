{
    lib,
    buildGoModule,
    fetchFromGitHub
}:

buildGoModule {
    pname = "ctrld";
    version = "1.3.6";

    src = (fetchFromGitHub {
        owner = "Control-D-Inc";
        repo = "ctrld";
        rev = "429a98b6900242743a82d417461c64162edc00d1";
        hash = "sha256-ybhofOfTax1lyV0JHU9menwEAXFmE288ZlBgKJuEnWI=";
    });

    vendorHash = "sha256-UN0gOFxMS0iWvg6Iv+aeYoduffJ9Zanz1htRh3ANjkY=";

    # Check seems to just time out every time?
    doCheck = false;

    meta = {
        description = "A highly configurable, multi-protocol DNS forwarding proxy";
        homepage = "https://github.com/Control-D-Inc/ctrld";
        license = lib.licenses.mit;
    };
}
