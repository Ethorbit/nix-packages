{
    buildPythonPackage,
    fetchFromGitHub,
    random-word,
    device-smi,
    tokenicer,
    logbar,
    accelerate,
    numpy,
    torch,
    safetensors,
    transformers,
    threadpoolctl,
    packaging,
    protobuf,
    pillow,
    hf-transfer,
    huggingface-hub,
    soundfile
}:

buildPythonPackage {
    pname = "gptqmodel";
    version = "3.0.0";

    src = (fetchFromGitHub {
        owner = "ModelCloud";
        repo = "GPTQModel";
        rev = "v3.0.0";
        hash = "sha256-MtR+2i8UApbRxBt/mXDFHcHE+2oEQMT127+veAmstuw=";
    });

    doCheck = false;

    propagatedBuildInputs = [
        random-word
        device-smi
        tokenicer
        logbar
        accelerate
        numpy
        torch
        safetensors
        transformers
        threadpoolctl
        packaging
        protobuf
        pillow
        hf-transfer
        huggingface-hub
        soundfile
    ];

    meta = {
        description = ''
            Production ready LLM model compression/quantization 
            toolkit with hw accelerated inference support 
            for both cpu/gpu via HF, vLLM, and SGLang.
        '';
        homepage = "https://github.com/ModelCloud/GPTQModel";
    };
}
