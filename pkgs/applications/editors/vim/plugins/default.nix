{
    vimUtils,
    callPackage
}:

{
    synthweave-nvim = callPackage ./synthweave-nvim {
        inherit (vimUtils) buildVimPlugin;
    };
}
