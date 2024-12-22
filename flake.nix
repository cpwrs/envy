{
  description = "Tiny & fast neovim configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    blink.url = "github:Saghen/blink.cmp";
    americano = {
      flake = false;
      url = "github:cpwrs/americano.nvim";
    };
  };
  
  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      
      perSystem = { config, self', pkgs, system, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              neovim = inputs.neovim.packages.${system}.neovim;
              envy = let
                plugins = with final.vimPlugins; [
                  oil-nvim
                  (final.vimUtils.buildVimPlugin {
                    name = "americano";
                    src = inputs.americano;
                  })
                  telescope-nvim
                  nvim-lspconfig
                  friendly-snippets
                  nvim-treesitter.withAllGrammars
                  inputs.blink.packages.${system}.default
                ];
                config = final.stdenv.mkDerivation {
                  name = "nvim-config";
                  src = ./.;
                  installPhase = ''
                    mkdir -p $out
                    cp -r . $out/
                  '';
                };
              in final.wrapNeovim final.neovim {
                configure = {
                  customRC = ''
                    set runtimepath+=${config}
                    luafile ${config}/init.lua
                  '';
                  packages.all.start = plugins;
                };
              };
            })
          ];
        };

        packages.default = pkgs.envy;
        
        apps.default = {
          type = "app";
          program = "${pkgs.envy}/bin/nvim";
        };
        
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.lua-language-server ];
        };
      };
    };
}
