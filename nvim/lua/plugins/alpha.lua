return {
	"goolord/alpha-nvim",
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[ __    __                             __              ]],
			[[|  \  |  \                           |  \             ]],
			[[| ▓▓\ | ▓▓ ______   ______  __     __ \▓▓______ ____  ]],
			[[| ▓▓▓\| ▓▓/      \ /      \|  \   /  \  \      \    \ ]],
			[[| ▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\]],
			[[| ▓▓\▓▓ ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[| ▓▓ \▓▓▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓  \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[| ▓▓  \▓▓▓\▓▓     \\▓▓    ▓▓   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓]],
			[[ \▓▓   \▓▓ \▓▓▓▓▓▓▓ \▓▓▓▓▓▓     \▓    \▓▓\▓▓  \▓▓  \▓▓]],
			[[                                                      ]],
		}
	end,
}
