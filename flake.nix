{
  description = "A basic flake for python development";
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flakelight.url = "github:accelbread/flakelight";
    
  };
  outputs = { flakelight, ... }@inputs:
    flakelight ./. ({ lib,  ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      devShell.packages = pkgs: with pkgs; ([
        # Add packages here
        python3
        nodejs_20
      ]);
    });
}
