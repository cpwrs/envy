{ pkgs }:
with pkgs.vimPlugins; [
	telescope-nvim
	nvim-lspconfig
	oil-nvim
	trouble-nvim
	nvim-treesitter	
]
