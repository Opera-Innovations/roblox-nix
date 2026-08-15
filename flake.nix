{
  description = "Flake for pesde CLI binary";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zap-flake.url = "github:c-gale/zap-flake";
    wally-flake.url = "github:c-gale/wally-flake";
    azul-flake.url = "github:c-gale/azul-flake";
    pesde-flake.url = "github:c-gale/psede-nix";
  };

  outputs = { self, nixpkgs, zap-flake, wally-flake, azul-flake, pesde-flake }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          rojo
          stylua

          azul-flake.packages.${system}.default
          pesde-flake.packages.${system}.pesde
          zap-flake.packages.${system}.zap
          wally-flake.packages.${system}.wally
        ];
      };
    };
}
