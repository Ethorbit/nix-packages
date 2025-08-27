{
    buildPythonPackage,
    fetchFromGitHub,
    transformers
}:

buildPythonPackage {
    pname = "Tokenicer";
    version = "0.0.4";

    src = (fetchFromGitHub {
        owner = "ModelCloud";
        repo = "Tokenicer";
        rev = "v0.0.4";
        hash = "sha256-neeY6YWouKNsvRmm+V1Q6hCAGKnE41fp9vDYfCUuqU0=";
    });

    buildInputs = [
        transformers
    ];

    doCheck = false;

    meta = {
        description = '' 
            A (nicer) tokenizer you want to use for model inference 
            and training: with all known peventable gotchas 
            normalized or auto-fixed.
        '';
        homepage = "https://github.com/ModelCloud/Tokenicer";
    };
}
