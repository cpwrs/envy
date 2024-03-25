{ pkgs }:
let
	plugins = import ./deps/plugins.nix { inherit pkgs; };
	customRC = import ./sourceConf.nix { inherit pkgs; };
in
  pkgs.wrapNeovim pkgs.neovim {
    configure = {
			inherit customRC;
      packages.all.start = plugins;
    };
  }
