--      .o oOOOOOOOo                                            OOOo
--      Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
--      OboO"""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo.."""""""""'OO
--      OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB'
--      `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
--      .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
--      OOOOO                 '"OOOOOOOOOOOOOOOO"`                oOO
--     oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
--    oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
--   OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
--   "OOOO"       "YOoOOOOMOIONODOO"`  .   '"OOROAOPOEOOOoOY"     "OOO"
--      Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
--      :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
--      .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
--                   '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
--                        `$"  `OOOO' `O"Y ' `OOOO'  o             .
--      .                  .     OP"          : o     .
--                                :
--                                .

-- Optics
vim.opt.background = 'dark'
vim.cmd.colorscheme("habamax")
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"

-- Coding
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.smartindent = true
vim.opt.colorcolumn = "80"

-- Behaviour
vim.opt.backup = false
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spell = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_altv = 1
vim.keymap.set('n', '<F5>', ':Lexplore<CR>')

-- Auto-commands
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	callback = function()
		vim.cmd("startinsert")
	end,
	desc = "Enter insert mode when entering terminal buffer window",
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


-- LSPs
vim.lsp.config("clangd", {
	cmd = { "clangd", "--background-index" },
	filetypes = { 'c', 'cpp' }
})
vim.lsp.enable("clangd")
vim.lsp.config('rust_analyzer', {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' }
})
vim.lsp.enable("rust_analyzer")
vim.lsp.config("pylsp", {
	cmd = { 'pylsp' },
	filetypes = { 'python' }
})
vim.lsp.enable("pylsp")

