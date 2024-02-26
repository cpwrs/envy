{ pkgs }:
let
	sourceConfig = dir:
		let
			# Build a directory where each file in ./conf is copied to.
			configDir = pkgs.stdenv.mkDerivation {
				name = "nvim-lua-config";
				src = ./${dir};
				installPhase = ''
					mkdir -p $out/
					cp -r ./* $out/
				'';
			};
		in 
			# Return a string that sources the config entry point lua file.
			# All other files are required as modules inside init.
			"luafile ${configDir}/init.lua";
in
	sourceConfig "conf"
