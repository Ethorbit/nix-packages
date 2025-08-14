{
    buildPythonPackage,
    fetchFromGitHub
}:

buildPythonPackage {
    pname = "LogBar";
    version = "0.0.4";

    src = (fetchFromGitHub {
        owner = "ModelCloud";
        repo = "LogBar";
        rev = "v0.0.4";
        hash = "sha256-fBqWrS++0xqvJlObMkk3algnc03R39j3G/QVgVG9kMI=";
    });

    doCheck = false;

    meta = {
        description = '' 
            A unified Logger and ProgressBar util with zero dependencies.
        '';
        homepage = "https://github.com/ModelCloud/LogBar";
    };
}
