{
  description = "Tiny & fast neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, neovim, flake-utils }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      overlayEnvy = prev: final: {
        envy = import ./envy.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlayFlakeInputs overlayEnvy ];
      };
    in {
      packages.x86_64-linux.default = pkgs.envy;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.envy}/bin/nvim";
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [ pkgs.lua-language-server ];
      };
    };
}
