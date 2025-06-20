{
    ethorbit,
    lib,
    buildPythonPackage,
    fetchurl,
    gobject-introspection,
    libnice,
    gst_all_1,
    pythonPackages,
    xsel,
    xorg,
    cudaPackages
}:

let
    version = "1.6.0";
    web = (pythonPackages.callPackage ./web.nix { inherit version; });
in
    buildPythonPackage {
        pname = "selkies-gstreamer";
        version = "${version}";

        format = "wheel";

        src = fetchurl {
            url = "https://github.com/selkies-project/selkies-gstreamer/releases/download/v${version}/selkies_gstreamer-${version}-py3-none-any.whl";
            sha256 = "sha256-BI4GJoiZUZ/haMvClk8xscxSiJEDGAWtBiJE6bVDRBI=";
        };

        nativeBuildInputs = [
            gobject-introspection
        ];

        buildInputs = [
            libnice.out
            gst_all_1.gstreamer.out
            gst_all_1.gst-libav
            gst_all_1.gst-devtools
            gst_all_1.gst-vaapi
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-ugly
            gst_all_1.gst-plugins-good
            xorg.xrandr
        ];

        propagatedBuildInputs = [
            ethorbit.pythonPackages.gputil
            ethorbit.pythonPackages.basicauth
            pythonPackages.gst-python
            pythonPackages.pygobject3
            pythonPackages.watchdog
            pythonPackages.xlib
            pythonPackages.pynput
            pythonPackages.msgpack
            pythonPackages.pillow
            pythonPackages.websockets
            pythonPackages.psutil
            pythonPackages.prometheus-client
        ];

        preFixup = ''
            for f in $(find $out/bin/ -type f -executable); do
                wrapProgram "$f" \
                  --prefix PATH ":" "${xsel}/bin:${xorg.xrandr}/bin/xrandr:$PATH" \
                  --prefix LD_LIBRARY_PATH ":" "${cudaPackages.cudatoolkit}/lib:$LD_LIBRARY_PATH" \
                  --prefix CUDA_PATH ":" "${cudaPackages.cudatoolkit}:$CUDA_PATH" \
                  --prefix SELKIES_WEB_ROOT ":" "${web}/gst-web" \
                  --prefix GI_TYPELIB_PATH ":" "${gobject-introspection.out}/lib/girepository-1.0:$GI_TYPELIB_PATH" \
                  --prefix GST_PY_PATH ":" "${pythonPackages.gst-python}/lib/python3.11" \
                  --prefix GST_PLUGIN_SYSTEM_PATH_1_0 ":" "${libnice.out}/lib/gstreamer-1.0:${gst_all_1.gstreamer.out}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0"
            done
        '';

        meta = {
            description = ''
                Open-Source Low-Latency Linux WebRTC HTML5 Remote Desktop 
                and 3D Graphics / Game Streaming Platform with GStreamer
            '';
            homepage = "https://github.com/selkies-project/selkies-gstreamer";
            license = lib.licenses.mpl20;
        };
    }
