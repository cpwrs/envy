{ pkgs }:
let
	plugins = import ./deps/plugins.nix { inherit pkgs; };
	config = import ./sourceConf.nix { inherit pkgs; };

  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
			inherit config;
      packages.all.start = plugins;
    };
  };
in pkgs.writeShellApplication {
  name = "nvim";
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
