{
    buildPythonPackage,
    fetchFromGitHub,
    lib,
    poetry-core,
    autopep8,
    pytest,
    pyyaml,
    requests
}:

buildPythonPackage {
    pname = "random-word";
    version = "1.0.13";
    format = "pyproject";

    src = (fetchFromGitHub {
        owner = "vaibhavsingh97";
        repo = "random-word";
        rev = "v1.0.13";
        hash = "sha256-h3GGGqQ/GiI6r3HNydz872WH5bGbGWkVmHOOFEVIJ+Y=";
    });

    buildInputs = [
        poetry-core
        autopep8
        pytest
        pyyaml
        requests
    ];

    meta = {
        description = ''
            This is a simple python package 
            to generate random english words
        '';

        homepage = "https://github.com/vaibhavsingh97/random-word";
        license = lib.licenses.mit;
    };
}
