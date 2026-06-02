{ buildDotnetGlobalTool, lib }:

buildDotnetGlobalTool {
    pname = "easydotnet";
    version = "3.2.4-alpha.1";

    nugetName = "EasyDotnet";
    nugetSha256 = "sha256-QZ4W4D5u97v2TFJia0aUU8W/22/O6OcG2CnXZtMqGVc=";

    executables = [ "dotnet-easydotnet" ];

    meta = {
        description = ''
        Easy Dotnet Server is the lightweight C# JSON-RPC server powering the easy-dotnet.nvim Neovim plugin.
        '';
        homepage = "https://www.nuget.org/packages/EasyDotnet";
        license = lib.licenses.mit;
        platforms = lib.platforms.all;
    };
}
