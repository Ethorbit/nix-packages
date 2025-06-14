{
    lib,
    buildPythonPackage,
    fetchFromGitHub,
    python-docx,
    gitpython
}:

buildPythonPackage rec {
    pname = "codebase_to_text";
    version = "1.0.7";

    src = (fetchFromGitHub {
        owner = "QaisarRajput";
        repo = "codebase_to_text";
        rev = "${version}";
        hash = "sha256-IfWFvEmSEHJSuYBpO2BrY4jDGhzXPt6p4Ha4dlGh4Fo=";
    });

    propagatedBuildInputs = [
        python-docx
        gitpython
    ];

    doCheck = false;

    meta = {
        description = ''
        For GenAI and LLM usage. This package converts codebase (folder structure with files) into a single text file or a Microsoft Word document (.docx), preserving folder structure and file contents. The tool extracts file contents from various file types, including text files, documents, and more, while retaining their formatting for easy readability.
        '';
        homepage = "https://github.com/QaisarRajput/codebase_to_text";
        license = lib.licenses.asl20;
    };
}
