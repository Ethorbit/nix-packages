# This is currently garbage as it crashes all the time
# https://github.com/jbwong05/obs-pulseaudio-app-capture/issues/15
#
# I switched to an alternative solution for the time being:
# https://github.com/jbwong05/obs-pulseaudio-app-capture/issues/15#issuecomment-2877825291

{
    lib,
    stdenv,
    fetchFromGitHub,
    cmake,
    zsh,
    obs-studio,
    qt6,
    libpulseaudio
}:

stdenv.mkDerivation (finalAttrs: {
    pname = "obs-pulseaudio-app-capture";
    version = "v0.2.0-alpha";

    src = (fetchFromGitHub {
        owner = "jbwong05";
        repo = "obs-pulseaudio-app-capture";
        rev = finalAttrs.version;
        sha256 = "sha256-AJNcSvJBmVfm+7AqvWCBoZ8e/6kwQSvibAYdv0vNwlc=";
    });

    nativeBuildInputs = [
        cmake
        zsh
        obs-studio
        qt6.full
    ];

    propagatedBuildInputs = [
        libpulseaudio
    ];

    meta = {
        description = "OBS plugin to capture application audio from PulseAudio";
        homepage = "https://github.com/jbwong05/obs-pulseaudio-app-capture";
        license = lib.licenses.gpl2;
        platforms = lib.platforms.linux;
    };
})
