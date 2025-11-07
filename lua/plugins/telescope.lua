return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		-- Load telescope-manix extension if available
		local has_manix = pcall(function()
			require("telescope").load_extension("manix")
		end)
		if has_manix then
			vim.keymap.set("n", "<leader>fn", function()
				require("telescope").extensions.manix.manix()
			end, { desc = "Search Nix options" })
		end
	end,
}
