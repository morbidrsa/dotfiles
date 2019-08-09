"    .o oOOOOOOOo                                            OOOo
"    Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
"    OboO"""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo.."""""""""'OO
"    OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB'
"    `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
"    .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
"    OOOOO                 '"OOOOOOOOOOOOOOOO"`                oOO
"   oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
"  oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
" OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
" "OOOO"       "YOoOOOOMOIONODOO"`  .   '"OOROAOPOEOOOoOY"     "OOO"
"    Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
"    :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?         .
"    .            oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
"                 '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
"                      `$"  `OOOO' `O"Y ' `OOOO'  o             .
"    .                  .     OP"          : o     .
"                              :
"                              .

filetype plugin indent on
syntax enable
set nocompatible
set smartindent
set autoindent
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
set textwidth=78
set cindent
set cinoptions=:0,l1,t0,g0,(0
set smarttab
set title
set ruler
set formatoptions=vt
set title
set hlsearch
set showmatch
set incsearch
set title
set exrc
set splitbelow
set splitright
set background=dark
set laststatus=2
set t_Co=256
set wildmenu

"highlight LineNr ctermfg=grey
"highlight Comment ctermfg=darkcyan
"highlight String ctermfg=darkmagenta
"highlight Include ctermfg=red
"highlight cIncluded ctermfg=blue
"highlight cPreCondit ctermfg=blue
"highlight Macro ctermfg=grey
"highlight StorageClass ctermfg=red
"highlight Structure ctermfg=red
"highlight Type ctermfg=red


let mapleader=","
inoremap jk <Esc>
vnoremap jk <Esc>

"spell checking
if version >= 700
	set spellfile="~./vim/user.add"
	set spelllang=en
	let spellst = ["en"]
	set sps=best,5
	hi SpellBad ctermfg=red ctermbg=none cterm=underline
	hi SpellCap ctermfg=blue ctermbg=none cterm=underline
endif

syn match ErrorLeadSpace /^ \+/
syn match ErrorTailSpace / \+$/

funct! InsertTimestamp()
        exe 'put =\"' . strftime("%a, %d %b %Y %H:%M:%S %z") . '\"'
endfunc
map <Leader>ts :call InsertTimestamp()<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>
map <F2> :NERDTreeToggle<CR>

au BufNewFile,BufRead *.txt setlocal spell
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
au BufNewFile,BufRead *.md setlocal spell
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.sls set filetype=yaml
au BufNewFile,BufRead *.go set filetype=go
au FileType gitcommit set tw=74

filetype plugin indent on
let g:linuxsty_patterns = [ "/linux/", "/kernel/", "/btrfs-progs/" ]


if has("gui_running")
	set background=dark
"	colorscheme=industry
	set guioptions-=T
	set relativenumber
endif
