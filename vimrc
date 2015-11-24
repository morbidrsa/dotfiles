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
set background=dark

"spell checking
if version >= 700
	set spellfile="~./vim/user.add"
	set spelllang=en
	let spellst = ["en"]
	set sps=best,5
	hi SpellBad ctermfg=Red ctermbg=black cterm=underline
	hi SpellCap ctermfg=blue ctermbg=black cterm=underline
endif

syn match ErrorLeadSpace /^ \+/
syn match ErrorTailSpace / \+$/
