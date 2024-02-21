{ pkgs }:
let
	plugins = import ../plugins.nix {inherit pkgs; };
	lsp = import ../lsp.nix { inherit pkgs; };	
  lsp1 = pkgs.symlinkJoin {
    name = "lsp1";
    paths = lsp.deps1;
  };
  lsp2 = pkgs.symlinkJoin {
    name = "lsp2";
    paths = lsp.deps2;
  };
  myNeovimUnwrapped = pkgs.wrapNeovim pkgs.neovim {
    configure = {
      packages.all.start = plugins;
    };
  };
in pkgs.writeShellApplication {
  name = "nvim";
  runtimeInputs = [ lsp1 lsp2 ];
  text = ''
    ${myNeovimUnwrapped}/bin/nvim "$@"
  '';
}
