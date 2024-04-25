{ pkgs }:
with pkgs.vimPlugins; [
  oil-nvim
	telescope-nvim
	nvim-lspconfig
	trouble-nvim
  nvim-treesitter.withAllGrammars
]
