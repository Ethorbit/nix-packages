{ pythonPackages }:

with pythonPackages;

{
    gputil = callPackage ./development/python-modules/gputil {};
    basicauth = callPackage ./development/python-modules/gputil {};
}
