set smartindent autoindent
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
set smarttab
set textwidth=78
set title
set ruler
set formatoptions=vt
filetype plugin indent on
syntax enable
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
set number

highlight LineNr ctermfg=grey

let mapleader=","

"spell checking
if version >= 700
	set spellfile="~./vim/user.add"
	set spelllang=en
	let spellst = ["en"]
	set sps=best,5
	hi SpellBad ctermfg=red ctermbg=none cterm=underline
	hi SpellCap ctermfg=blue ctermbg=none cterm=underline
endif

func GitGrep(...)
	let save = &grepprg
	set grepprg=git\ grep\ -n\ $*
	let s = 'grep'
	for i in a:000
		let s = s . ' ' . i
	endfor
	exe s
	let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

syn match ErrorLeadSpace /^ \+/
syn match ErrorTailSpace / \+$/

funct! InsertTimestamp()
        exe 'put =\"' . strftime("%a, %d %b %Y %H:%M:%S %z") . '\"'
endfunc
map <Leader>ts :call InsertTimestamp()<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>

au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
au BufNewFile,BufRead *.md setlocal spell
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.sls set filetype=yaml

filetype plugin indent on
let g:linuxsty_patterns = [ "/linux/", "/kernel/" ]

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256

