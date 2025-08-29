{
    python,
    stdenv,
    fetchFromGitHub,
    gptqmodel
}:

let
    name = "taggui";

    pythonEnv = python.withPackages (ps: with ps; [
         gptqmodel
         accelerate
         bitsandbytes
         exifread
         imagesize
         pillow
         pyparsing
         pyside6
         transformers
         timm
         einops
         protobuf
         sentencepiece
         torchvision
         numpy
         huggingface-hub
         onnxruntime
         datasets
    ]);
in
    stdenv.mkDerivation {
        inherit name;
        src = (fetchFromGitHub {
            owner = "jhc13";
            repo = "taggui";
            rev = "v1.33.0";
            hash = "sha256-d02xDtnps26RF6G8cMZfHNw7yrukVi7vI+Sg1SaHwxg=";
        });

        installPhase = ''
            cp -r ./ $out/

            # It appears the author expects people to run the executable manually
            # I'm going to create a desktop entry for this.
            mkdir -p $out/share/applications
            cat > $out/share/applications/${name}.desktop << EOF
            [Desktop Entry]
            Name=taggui
            Exec=${pythonEnv}/bin/python $out/taggui/run_gui.py
            Type=Application
            Categories=Utility;
            EOF
        '';

        meta = {
            description = '' 
                Tag manager and captioner for image datasets
            '';
            homepage = "https://github.com/jhc13/taggui";
        };
    }
