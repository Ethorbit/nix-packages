{
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    pyqt5,
    libsForQt5,
    vdf,
    docopt,
    importlib-resources,
    setuptools   
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

    pyproject = true;
    build-system = [ setuptools ];

    propagatedBuildInputs = [
        pyqt5
        vdf
        docopt
        importlib-resources
    ];

    nativeBuildInputs = [
        libsForQt5.wrapQtAppsHook
    ];

    dontWrapQtApps = true;
    preFixup = ''
        makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    '';

    doCheck = false;

    meta = {
        description = "Lightweight Steam Account Switcher";
        homepage = "https://github.com/coldfix/steam-acolyte";
        license = lib.licenses.unlicense;
        platforms = lib.platforms.linux;
    };
}
