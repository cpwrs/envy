{
  description = "Tiny & fast neovim configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://cache.nixos.org"
    ];

    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    blink.url = "github:Saghen/blink.cmp";
    americano = {
      flake = false;
      url = "github:cpwrs/americano.nvim";
    };
  };

  outputs = {
    self,
    nixpkgs,
    blink,
    americano,
    ...
  }: let
    forEachSystem = fn:
      nixpkgs.lib.genAttrs
      nixpkgs.lib.platforms.unix (system: fn nixpkgs.legacyPackages.${system});
  in {
    packages = forEachSystem (pkgs: {
      default = let
        plugins = with pkgs.vimPlugins; [
          oil-nvim
          telescope-nvim
          nvim-lspconfig
          friendly-snippets
          nvim-treesitter.withAllGrammars
          blink.packages.${pkgs.stdenv.hostPlatform.system}.default
          # Build americano vim plugin from input
          (pkgs.vimUtils.buildVimPlugin {
            name = "americano";
            src = americano;
          })
        ];
      in
        pkgs.wrapNeovim pkgs.neovim-unwrapped {
          configure = {
            customRC = ''
              set runtimepath+=${./.}
              luafile ${./.}/init.lua
            '';
            packages.all.start = plugins;
          };
        };
    });

    apps = forEachSystem (pkgs: let
      envy = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in {
      default = {
        type = "app";
        program = "${envy}/bin/nvim";
      };
    });

    devShells = forEachSystem (pkgs: {
      default = pkgs.mkShell {
        packages = [
          pkgs.lua-language-server
          pkgs.nixd
          pkgs.alejandra
        ];
      };
    });
  };
}
