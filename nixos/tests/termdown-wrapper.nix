{
    pkgs
}:

pkgs.nixosTest {
    name = "termdown-wrapper";

    nodes = {
        machine = { config, pkgs, ... }: {
            imports = [
                ../modules
            ];

            programs.termdown-wrapper.enable = true;
        };
    };

    testScript = ''       
        machine.start()
        print(machine.succeed("which timer.sh"))
    '';
}
