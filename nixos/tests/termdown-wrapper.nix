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

            ethorbit.programs.termdown-wrapper.enable = true;
        };
    };

    testScript = ''       
        machine.start()
        print(machine.succeed("which timer.sh"))
    '';
}
