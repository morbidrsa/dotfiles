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

-- Coding
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.smartindent = true

-- Behaviour
vim.opt.backup = false
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spell = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

-- Auto-commands
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	callback = function()
		vim.cmd("startinsert")
	end,
	desc = "Enter insert mode when entering terminal buffer window",
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
