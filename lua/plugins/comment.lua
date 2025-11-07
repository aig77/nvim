return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()

		-- Line comment toggle (like VS Code)
		vim.keymap.set("n", "<leader>/", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Toggle line comment" })

		vim.keymap.set("v", "<leader>/", function()
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			require("Comment.api").toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle line comment" })

		-- Block comment toggle
		vim.keymap.set("n", "<leader>cb", function()
			require("Comment.api").toggle.blockwise.current()
		end, { desc = "Toggle block comment" })

		vim.keymap.set("v", "<leader>cb", function()
			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
			vim.api.nvim_feedkeys(esc, "nx", false)
			require("Comment.api").toggle.blockwise(vim.fn.visualmode())
		end, { desc = "Toggle block comment" })
	end,
}
