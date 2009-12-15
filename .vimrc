" 
" Sam's .vimrc
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set bs=2 " makes backspace work normally
set mouse=a
filetype on " detect the type of file
filetype plugin on " load filetype plugins
set cf " enable error files and error jumping
set clipboard+=unnamed " shares windows clipboard
set ffs=unix,dos,mac " support for all three in that order
set history=1000 " how many lines of history to remember
set isk+=_,$,@,*,#,- " makes these characters not be word dividers
set nocompatible "out of the vi-compatible mode
set viminfo+=! " make sure it can save viminfo 
" command line completeion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
" have mouse enabled all the time
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME/COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme koehler
syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cmdheight=2 " sets the command bar to 2 high
set guifont=DejaVu_Sans_Mono:h10:cANSI
set hid " change buffer without saving
set hidden " Natural buffer display
set laststatus=2 " always show the status line
set noerrorbells " no noises
set novisualbell " don't blink
set number " line numbers
set ruler " Displays position in the file
set showcmd
set so=10 " Keep 1- lines (top/bottom) for scope
set textwidth=80 " Sets the max width text can be before vim inserts a linebreak
set title " puts info in the term title bar
set ttyfast " makes things faster, supposedly

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT FORMATTING / GENERAL
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tabstop=4
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=start,indent

" Some file type really do require explicit tabs
autocmd FileType make       set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCH & REPLACE 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make searches case insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the 'best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitions to replace all matches in a line:
set gdefault


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPELLING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Correct common typos without me even noticing them
abbrev teh the
abbrev spolier spoiler

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYSTROKES - MOVING AROUND
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use <F6> to cycle through split windows ( and <Shift>+<F6> to cycle
" backwards, where possible
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle trhough files
"nnoremap <C-N> :next<CR>
"nnoremap <C-P> :prev<CR>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" use <Ctrl>+<Tab> to cycle through tabs
nnoremap <C-N> :tabn<CR>
nnoremap <C-P> :tabp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYSTROKES - FORMATTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MinBufExpl
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ABBREVS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xday <c-r>=strftime("%d/%m/%y")<cr>
iab xtime <c-r>=strftime("%H:%M:%S")<cr>
iab xname samerrel

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
