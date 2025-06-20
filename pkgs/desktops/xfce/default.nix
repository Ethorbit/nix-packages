{
    callPackage,
    python312Packages
}:

{
    watch-xfce-xfconf = (
        python312Packages.callPackage ./applications/watch-xfce-xfconf {}
    );
}
