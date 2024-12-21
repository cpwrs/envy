{
  description = "Tiny & fast neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    americano = {
      flake = false;
      url = "github:cpwrs/americano.nvim";
    };
  };
  outputs = { self, nixpkgs, neovim, americano }:
    let
      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };
      overlayEnvy = prev: final: {
        envy = let
          americano-plug = final.vimUtils.buildVimPlugin {
            name = "americano";
            src = americano;
          };
          plugins = with final.vimPlugins; [
            oil-nvim
            blink-cmp
            friendly-snippets
            americano-plug
            telescope-nvim
            nvim-lspconfig
            nvim-treesitter.withAllGrammars
          ];
          config = pkgs.stdenv.mkDerivation {
            name = "nvim-config";
            src = ./.;
            installPhase = ''
              mkdir -p $out
              cp -r . $out/
            '';
          };
        in
          final.wrapNeovim final.neovim {
            configure = {
              customRC = ''
                set runtimepath+=${config}
                luafile ${config}/init.lua
              '';
              packages.all.start = plugins;
            };
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
