{
    lib,
    version,
    stdenv,
    fetchurl
}:

stdenv.mkDerivation {
    name = "selkies-gstreamer-web";

    src = fetchurl {
        url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v${version}/selkies-gstreamer-web_v${version}.tar.gz";
        sha256 = "sha256-9laKZvinvEi92VHNOjVgwCFQmfUm8QVuL3sUrbiq0QA=";
    };

    installPhase = ''
        mkdir -p $out
        tar -xzf $src -C $out/
    '';

    meta = {
        description = "The HTML5/JS web components for Selkies-Gstreamer.";
        homepage = "https://github.com/selkies-project/selkies-gstreamer";
        license = lib.licenses.mpl20;
    };
}
