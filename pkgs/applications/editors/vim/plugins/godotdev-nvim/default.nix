{
    buildVimPlugin,
    fetchFromGitHub
}:

buildVimPlugin rec {
    pname = "godotdev-nvim";
    version = "0.8.1";

    src = (fetchFromGitHub {
        owner = "Mathijs-Bakker";
        repo = "godotdev.nvim";
        rev = "0.8.1";
        hash = "sha256-JqrXrko/sXjJHCcvROJO62zlVHzNHb07NeQQ0HfhwI8=";
    });

    meta = {
        description = ''
        Neovim plugin for Godot 4 with GDScript LSP, GDShader support, 
        C#, DAP debugging, Godot console output, formatting, health checks, 
        static scene tree inspector, and in-editor Godot docs.
        '';
        homepage = "https://github.com/${src.owner}/${src.repo}";
    };
}
