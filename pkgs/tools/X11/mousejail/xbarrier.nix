{
    lib,
    stdenv,
    fetchFromGitHub,
    libgcc,
    pkg-config,
    xorg
}:

stdenv.mkDerivation {
    name = "xbarrier";

    src = (fetchFromGitHub {
        owner = "pfanne";
        repo = "mousejail";
        rev = "b2f84d5002a6925aaa1261aaf36470534dd3d5e3";
        hash = "sha256-zZPILPphKB9e+IJSvPrfPkbwN4PFS8zTvXi/bfBWzqM=";
    });

    buildInputs = [
        libgcc
        pkg-config
        xorg.libX11
        xorg.libXtst
        xorg.libXfixes
    ];
    buildPhase = ''
        gcc xbarrier.c $(pkg-config --cflags --libs x11 xfixes) -o xbarrier
    '';
    installPhase = ''
        mkdir -p "$out/bin"
        cp xbarrier "$out/bin/xbarrier"
        chmod +x "$out/bin/xbarrier"
    '';

    meta = {
        description = "A simple executable and script that allows the user to jail the mouse cursor inside a window";
        homepage = "https://github.com/pfanne/mousejail";
        platforms = lib.platforms.linux;
    };
}
