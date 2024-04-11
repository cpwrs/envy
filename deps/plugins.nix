{ pkgs }:
with pkgs.vimPlugins; [
	telescope-nvim
	nvim-lspconfig
	trouble-nvim
  nvim-treesitter.withAllGrammars
]
