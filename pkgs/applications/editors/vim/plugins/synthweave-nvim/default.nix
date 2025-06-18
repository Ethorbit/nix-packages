{
    lib,
    buildVimPlugin,
    fetchFromGitHub
}:

buildVimPlugin {
    pname = "synthweave-nvim";
    version = "1.0.0";

    src = (fetchFromGitHub {
        owner = "samharju";
        repo = "synthweave.nvim";
        rev = "50cb17af14dbdf8a2af634c40b9b20298f67aba0";
        hash = "sha256-kxfTnmzUnF2tgBf1Ic/3xNWeEffbsKEyxxNXPV4bTbQ=";
    });

    meta = {
        description = "Synthwave '84 colorscheme port for Neovim";
        homepage = "https://github.com/samharju/synthweave.nvim";
        license = lib.licenses.mit;
    };
}
