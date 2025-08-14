{
    buildPythonPackage,
    fetchFromGitHub
}:

buildPythonPackage {
    pname = "Device-SMI";
    version = "0.4.1";

    src = (fetchFromGitHub {
        owner = "ModelCloud";
        repo = "Device-SMI";
        rev = "v0.4.1";
        hash = "sha256-Pkrq28PqPWQ/RZGqGOFvGmDx4kIUuIL3/t0zaf/Gw8w=";
    });

    doCheck = false;

    meta = {
        description = '' 
            Self-contained Python lib with zero-dependencies 
            that give you a unified device properties for 
            gpu, cpu, and npu. No more calling separate 
            tools such as nvidia-smi or /proc/cpuinfo 
            and parsing it yourself.
        '';
        homepage = "https://github.com/ModelCloud/Device-SMI";
    };
}
