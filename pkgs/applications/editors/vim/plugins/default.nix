{
    vimUtils,
    callPackage
}:

{
    confirm-quit = callPackage ./confirm-quit {
        inherit (vimUtils) buildVimPlugin;
    };

    synthweave-nvim = callPackage ./synthweave-nvim {
        inherit (vimUtils) buildVimPlugin;
    };
}
