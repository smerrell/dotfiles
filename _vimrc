" https://github.com/smerrell/dotfiles
"

set nocompatible        " vim > vi mode.
let mapleader = ","     " change <leader> from \ to ,

"
" Pathogen
"
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" ======================
" Basics
" ======================
set mouse=a             " Always enable mouse
set clipboard+=unnamed  " Makes using clipboard easier
set t_Co=256            " For 256 color mode support
set number              " Show line numbers
set numberwidth=1       " Try to use only 1 col when possible
set nowrap              " Line wrapping off
set cursorline          " Highlight line cursor is on

" ,v brings up .vimrc (thanks, sontek)
" ,V reloads it (as long as you remember to save it first)
map <leader>v :sp ~/.vimrc<CR><C-W>
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"
" Moving around / editing
"
set nostartofline       " Avoid moving cursor to BOL when moving
set scrolloff=5         " Keep 5 lines (top/bottom) for scope
set backspace=2         " Allow backspace over autoindent, EOL, and BOL
set showmatch           " Show matched paren when balanced
set matchtime=2         " for .2 seconds
set linebreak           " Don't wrap text in the middle of a word

"
" Windowing
"
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" and lets make these all work in insert mode too ( <C-O> makes next cmd
" happen as if in command mode )
imap <C-W> <C-O><C-W>

" Window resizing made easy
map <A-k> <C-w>+
map <A-j> <C-w>-
map <A-l> <C-w>>
map <A-h> <C-w><
"
" Tabs
"
map th :tabfirst<CR>
map tk :tabnext<CR>
map tj :tabprev<CR>
map tl :tablast<CR>
map tt :tabedit<Space>
map tn :tabnext<Space>
map tm :tabm<Space>
map <silent><C-N> :tabn<CR>

"
" Search / Replace
"
set incsearch           " Show best match while typing a search
set ignorecase          " Case insensitive search
set smartcase           " Unless uppercase used in search expr.
set gdefault            " Default to /g global replace
set hlsearch            " Highlight searches and search results
" clear highlighted search using the space bar
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

"
" Display
"

if has('gui_running')
  colorscheme solarized
  set bg=dark

  " Remove toolbar
  set guioptions-=T
  " Remove right-hand scroll bar
  set guioptions-=r
  " Removes the menu
  set guioptions-=m
  " Use console dialogs instead of popup dialogs for simple choices
  set guioptions+=c
else
  colorscheme wombat256mod
endif

if has("gui_gtk2")
  set guifont=Ubuntu\ Mono\ 14,Anonymous\ Pro\ 14,DejaVu\ Sans\ Mono\ 14
elseif has("gui_win32")
  set guifont=Ubuntu\ Mono:h14,Anonymous\ Pro:h14,DejaVu\ Sans\ Mono:h14,Consolas:h14
elseif has("gui_macvim")
  set guifont=Ubuntu\ Mono:h16,Anonymous\ Pro:h16,Menlo:h16
endif


"
" Messages, Info, & Status
"
set novisualbell        " No blinking
set noerrorbells        " No noise
set cmdheight=2         " Cmd bar 2 rows high
set showcmd             " Show partial command in the last line of the screen
set report=0            " : commands always print changed line count
set shortmess+=a        " Use [+]/[RO]/[w] for modified/readonly/written
set laststatus=2        " Always show the status line
set ruler               " Display position in the file

"
" Tabs / indentation
"
set shiftwidth=2        " Indent level is 2 spaces wide
set softtabstop=2       " <BS> over an autoindent deletes shiftwidth worth of spaces
set smarttab            " Insert blanks properly at beginning of a line
set autoindent          " Copy indent from current line when starting a new line
set expandtab           " Use spaces not tabs

" Show all tab chars and trailing whitespace
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set list

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
set wildignore+=*.o,*.obj,.git,*.pyc.

" Linux / Mac
set wildignore+=*/.git/*

" Windows
set wildignore+=.git\*,Build\*,.sass-cache\*

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

" set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Paste from clipboard
map <leader>p "+gP

" Remove trailing whitespace
map <leader>e :%s/\s\+$//<CR>:let @/=''<CR>

" Toggle tasklist
map <leader>td <Plug>TaskList

" NERD Tree Settings
map <F4> :NERDTreeFind<CR>
map <F3> :NERDTreeToggle<CR>

let Tlist_GainFocus_On_ToggleOpen=1

"
" Filetype Maps
"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"set statusline=%<\ %n:%f\ %m%r%y%{SyntasticStatuslineFlag()}%=line:\ %l\ of\ %L,\ col:\ %c%V,\

autocmd BufRead * set vb t_vb=            " No bells. Period.
autocmd BufRead *.spark set filetype=html
autocmd BufRead *.rst set tw=80
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType spark set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType scss set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
