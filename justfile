set positional-arguments := true

lint +files="src/":
	selene {{files}}
	curl -o dumpRobloxTypes.py https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/dumpRobloxTypes.py
	python dumpRobloxTypes.py > globalTypes.d.lua
	rojo sourcemap default.project.json > sourcemap.json
	luau-lsp analyze --sourcemap=sourcemap.json --definitions=globalTypes.d.lua --base-luaurc=.luaurc --ignore=**/_Index/** {{files}}

format +files="src/":
	stylua {{files}}
