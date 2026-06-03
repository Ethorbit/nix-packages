{
    buildVimPlugin,
    fetchFromGitHub,
    lib
}:

buildVimPlugin rec {
    pname = "header-nvim";
    version = "1.0.0";

    src = (fetchFromGitHub {
        owner = "attilarepka";
        repo = "header.nvim";
        rev = "3c432ef2521fe079f32f8f01ff3efb97a8a84a1e";
        hash = "sha256-61juWA3wSog6uYBhyj1FXACJ+uMmTiInMZVQpGLpxl4=";
    });

    meta = {
        description = ''
        Add or update copyright and license headers in any source file—right from Neovim
        '';
        homepage = "https://github.com/${src.owner}/${src.repo}";
        license = lib.licenses.mit;
    };
}
