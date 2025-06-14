{
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    psutil,
    lxml,
}:

buildPythonPackage rec {
    pname = "watch-xfce-xfconf";
    version = "1.0.5";

    src = (fetchFromGitHub {
        owner = "jamescherti";
        repo = "watch-xfce-xfconf";
        rev = "v${version}";
        hash = "sha256-CkKZ8ro2nZJ5h8Vxa9xvuMgiIgp6mWC4jIQWAX2xMO4=";
    });

    propagatedBuildInputs = [
        psutil
        lxml
    ];

    doCheck = false;

    meta = {
        description = ''watch-xfce-xfconf: Configure XFCE 4 programmatically using the xfconf-query commands displayed by watch-xfce-xfconf'';
        homepage = "https://github.com/jamescherti/watch-xfce-xfconf";
        license = lib.licenses.mit;
        platforms = lib.platforms.linux;
    };
}
