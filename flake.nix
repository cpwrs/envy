{
  description = "Tiny & fast neovim configuration";
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    americano = {
      flake = false;
      url = "github:cpwrs/americano.nvim";
    };
  };
  outputs = {
    self,
    nixpkgs,
    americano,
    ...
  }: let
    forEachSystem = fn:
      nixpkgs.lib.genAttrs
      nixpkgs.lib.platforms.unix (system: fn nixpkgs.legacyPackages.${system});
  in {
    packages = forEachSystem (pkgs: {
      default = let
        plugins = with pkgs.vimPlugins;
          [
            blink-cmp
            gitsigns-nvim
            oil-nvim
            telescope-nvim
            nvim-lspconfig
            friendly-snippets
            nvim-treesitter.withAllGrammars
            nvim-treesitter-textobjects
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
