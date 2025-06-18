{
    buildVimPlugin,
    fetchFromGitHub
}:

buildVimPlugin {
    pname = "confirm-quit";
    version = "1.0.0";

    src = (fetchFromGitHub {
        owner = "vim-scripts";
        repo = "confirm-quit";
        rev = "master";
        hash = "sha256-s1mZoZlc8vbgA1X43fXVz+cixSWcFbhkfMJL2a1hrhs=";
    });

    meta = {
        description = "Ask for confirmation before quitting Vim";
        homepage = "https://github.com/vim-scripts/confirm-quit";
    };
}
