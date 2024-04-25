{ pkgs }:
let
  # List all plugins we want ported to pkgs.vimPlugins
	plugins = with pkgs.vimPlugins; [
    oil-nvim
	  telescope-nvim
	  nvim-lspconfig
	  trouble-nvim
    nvim-treesitter.withAllGrammars
  ];

  # Make a derivation with our config files.
  # Add all derivation files to our nvim runtimepath and source them.
  sourceConfig = dir:
    let
      # Derivation where each file of conf/ is copied to.
      configDir = pkgs.stdenv.mkDerivation {
        name = "nvim-lua-config";
        src = ./${dir};
        installPhase = ''
          mkdir -p $out/
          cp -r ./* $out/
        '';
      };
    in
      # Return a string that sources the config entry point.
      ''
        set runtimepath+=${configDir}
        luafile ${configDir}/init.lua
      '';
in
  pkgs.wrapNeovim pkgs.neovim {
    configure = {
      customRC = sourceConfig "conf";
      packages.all.start = plugins;
    };
  }
