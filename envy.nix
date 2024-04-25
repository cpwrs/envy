{ pkgs }:
let
	plugins = import ./plugins.nix { inherit pkgs; };
	customRC = import ./sourceConf.nix { inherit pkgs; };
in 
  pkgs.wrapNeovim pkgs.neovim {
    configure = {
			inherit customRC;
      packages.all.start = plugins;
    };
  }
