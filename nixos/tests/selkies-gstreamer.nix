{
    pkgs
}:

pkgs.nixosTest {
    name = "selkies-gstreamer";

    nodes = {
        machine = { config, pkgs, ... }: {
            imports = [
                ../modules
                ./common/user-account.nix
            ];

            programs.selkies-gstreamer = {
                enable = true;

                settings = {
                    user = "alice";
                    display.webRTC.encoder = "x264enc";
                };
            };
        };
    };

    testScript = ''
        machine.start()

        # 5 secs restart time for service
        # We will log the last 50 lines of two starts
        for i in range(2):
            print(f"=== LOG ITERATION {i} ===")
            machine.succeed("journalctl --no-pager -n 50 || true")
            machine.sleep(5)

        try:
           machine.wait_for_x()
        except Exception as e:
           print("X did not start:", e)

        machine.wait_for_unit("selkies-gstreamer.service", user="alice")
        machine.succeed("pgrep -f selkies-gstreamer")

        # Check if the WebRTC connection works
        machine.wait_for_open_port(8080)
    '';
}
