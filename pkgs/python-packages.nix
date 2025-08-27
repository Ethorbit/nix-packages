{ python }:

with python.pkgs;

let
    self = {
        basicauth = callPackage ./development/python-modules/basicauth {};
        device-smi = callPackage ./development/python-modules/device-smi {};
        gputil = callPackage ./development/python-modules/gputil {};
        gptqmodel = callPackage ./development/python-modules/gptqmodel {
            inherit (self) random-word device-smi tokenicer logbar;
        };
        logbar = callPackage ./development/python-modules/logbar {};
        tokenicer = callPackage ./development/python-modules/tokenicer {};
        random-word = callPackage ./development/python-modules/random-word {};
    };
in
    self
