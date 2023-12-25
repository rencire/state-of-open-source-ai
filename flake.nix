{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    devenv.url = "github:cachix/devenv";
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        #packages.default = pkgs.hello;

        devenv.shells.default = {
          # https://devenv.sh/reference/options/
          #packages = [ config.packages.default ];

          languages.python = {
            enable = true;
            #version = "3.12";
            venv.enable = true;
            venv.requirements = ./requirements.txt;
          };

          enterShell = ''
            echo "welcome to my shell"
          '';

          env = {
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
          };
        };
      };
    };
}
