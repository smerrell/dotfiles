" Author: Sam Merrell (merrell.sam@gmail.com)
" 

set nocompatible " vim > vi mode.

colorscheme koehler

"
" Moving around / editing
"
set nostartofline       " Avoid moving cursor to BOL when moving
set scrolloff=5         " Keep 5 lines (top/bottom) for scope
set backspace=2         " makes backspace work normally
set showmatch           " Show matched paren when balanced
set matchtime=2         " for .2 seconds
set linebreak           " Don't wrap text in the middle of a word
set mouse=a             " Always enable mouse
set clipboard+=unnamed  " Makes using clipboard easier
" Navigate by display line NOT by actual line
nnoremap j gj
nnoremap k gk
" Navigate by actual line NOT by display line
nnoremap gj j
nnoremap k gk

"
" Search / Replace
"
set incsearch           " Show best match while typing a search
set ignorecase          " Case insensitive search
set smartcase           " Unless uppercase used in search expr.
set gdefault            " Default to /g global replace

"
" Display
"
"set guifont=DejaVu_Sans_Mono:h10:cANSI
set guifont=DejaVu\ Sans\ Mono\ 11
set number              " Show line numbers
set numberwidth=1       " Try to use only 1 col when possible
set background=dark
set textwidth=110       " Sets the max width text can be before vim inserts a linebreak
set guioptions+=c       " Use console dialogs instead of popup dialogs for simple choices
set guioptions-=T       " Remove toolbar
set guioptions-=r       " Remove right-hand scroll bar

"
" Messages, Info, & Status
"
set vb t_vb=            " No bells. Period.
set cmdheight=2         " Cmd bar 2 rows high
set showcmd             " Show partial command in the last line of the screen
set report=0            " : commands always print changed line count
set shortmess+=a        " Use [+]/[RO]/[w] for modified/readonly/written
set laststatus=2        " Always show the status line
set ruler               " Display position in the file

"
" Tabs / indentation
"
set tabstop=4           " Use 4 spaces for <tab>
set shiftwidth=2        " Indent level is 2 spaces wide
set softtabstop=2       " <BS> over an autoindent deletes shiftwidth worth of spaces
set smarttab            " Insert blanks properly at beginning of a line
set autoindent          " Copy indent from current line when starting a new line
set expandtab           " Use spaces not tabs

" Some file type really do require explicit tabs
autocmd FileType make       set noexpandtab

"
" Reading/Writing
"
set noautowrite         " Never write a file unless requested to
set noautowriteall      " Seriously.
set modeline            " Let vim options be embedded in files;
set modelines=5         " when in first or last 5 lines
set ffs=unix,dos,mac    " Try and recognize line endings in that order

"
" Backup / Swap files
"
set noswapfile

"
" Command Line
"
set history=1000        " Remember a long command history
set wildmenu            " Menu completion in command mode on <Tab>
" First list the available options and complete the longest common part, then have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

"
" Per-Filetype Scripts
"
filetype on             " File type detection on
filetype indent on      " Use filetype-specific indenting when available
filetype plugin on      " Load filetype plugins
syntax on               " Enable per-filetype syntax highlighting


"
" Key Mappings
"

" Move between tabs
map <silent><C-N> :tabn<CR>
map <silent><C-P> :tabp<CR>

" change <leader> from \ to ,
let mapleader = ","

"
" Abbrevs
"
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xday <c-r>=strftime("%d/%m/%y")<cr>
iab xtime <c-r>=strftime("%H:%M:%S")<cr>
iab xname samerrel

" execute selected script
map <C-h> :py EvaluateCurrentRange()<CR>

" Show tasks in current buffer
map T :TaskList<CR><C-w><Left>

" Show Project Menu
map <F3> :NERDTreeToggle<CR>

let Tlist_GainFocus_On_ToggleOpen=1

"
" Python tweaks (from Sontek - http://github.com/sontek/dotfiles)
"

" treat html files as django templates
autocmd BufRead *.html set filetype=htmldjango

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"      
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m       

if has("python")
python << EOF
import os
import sys
import vim
# lets us use 'gf' to go to files imported
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))

# lets us execute the highlighted portion of the script
def EvaluateCurrentRange():
  eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOF
endif
