{
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    pyqt5,
    vdf,
    docopt,
    importlib-resources,
    qt5
}:

buildPythonPackage rec {
    pname = "steam-acolyte";
    version = "0.10.0";

    src = (fetchFromGitHub {
        owner = "coldfix";
        repo = "steam-acolyte";
        rev = "v${version}";
        hash = "sha256-ZVvuEvoXUmmUoOZJPLDVbQ7XvplP3ezhD6lhS0WfjiQ=";
    });

    propagatedBuildInputs = [
        pyqt5
        vdf
        docopt
        importlib-resources
        qt5.full
    ];

    doCheck = false;

    meta = {
        description = "Lightweight Steam Account Switcher";
        homepage = "https://github.com/coldfix/steam-acolyte";
        license = lib.licenses.unlicense;
        platforms = lib.platforms.linux;
    };
}
