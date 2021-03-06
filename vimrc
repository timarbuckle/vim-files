" vim: foldmethod=marker :
set foldmethod=indent
set foldlevel=99

"
" {{{ Basic Config
"
set nocompatible
filetype off

" Include pathogen
call pathogen#infect()
"call pathogen#helptags()

set number
set nuw=6
set ruler
syntax on

" Set encoding
set encoding=utf-8

let mapleader=','

" Whitespace stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set showmode
set showcmd
set showmatch
set hidden
"set list listchars=tab:▸\ ,eol:¬,trail:·
set list listchars=tab:▸\ ,trail:·
set noeol
set autoindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Window settings
set wrap
set lbr
set textwidth=79
set cursorline
set formatoptions=qrn1
"set colorcolumn=85

" Use modeline overrides
set modeline
set modelines=10

" Status bar
set laststatus=2
"old status line
"set statusline=%t\ %y\ format:\ %{&ff};\ [%l,%c]
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor"
set statusline +=%{fugitive#statusline()}
" set how many lines of history vim has to retain
set history=700

" make 256 colors work from Ubuntu
set t_Co=256

" Default color scheme
"set guifont=Bitstream\ Vera\ Sans\ Mono:h14
"let g:solarized_visibility='medium'
"let g:solarized_contrast='normal'
"set background=light
"set background=dark
":colorscheme mustang
":colorscheme chela_light
":colorscheme wombat
":colorscheme umber-green
":colorscheme professional
":color solarized
":colorscheme synic
if has('gui_running')
    ":colorscheme github
    ":colorscheme pablo
    ":colorscheme codeschool
    ":colorscheme molokai
    ":colorscheme asu1dark

    ":colorscheme habilight
    :colorscheme mustang

    "turn off ugly toolbar
    "set guioptions=egmrt
    set guioptions-=T
    "set pct transparency
    set transparency=0
    if has("mac")
        set guifont=Ubuntu\ Mono:h16
    elseif has("unix")
        set guifont=Ubuntu\ Mono\ 14
    else
    endif
else
    ":colorscheme codeschool
    ":colorscheme summerfruit256
    :colorscheme mustang
endif

if v:version >= 700
  let s:saved_statusline = &statusline
  "highlight statusLine cterm=bold ctermfg=black ctermbg=red
  "au InsertLeave * highlight StatusLine cterm=bold ctermfg=black ctermbg=red guibg=black guifg=red
  " the following InsertLeave is for summerfruit256 theme
  au InsertLeave * highlight StatusLine term=bold,reverse cterm=bold ctermfg=231 ctermbg=41 gui=bold guifg=#ffffff guibg=#43c464
  au InsertEnter * highlight StatusLine cterm=bold ctermfg=black ctermbg=green guibg=black guifg=green
endif

" Context-dependent cursor in the terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7""

" Swap files. Generally things are in version control
" don't use backupfiles either.
set noswapfile
set nobackup
set nowritebackup

" Persistent undos
if !&diff
  set undodir=~/.vim/backup
  set undofile
endif

" }}}

" {{{ Searching
"
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
"nnoremap / /\v
"vnoremap / /\v
set grepprg=ack\ --column
set grepformat=%f:%l:%c:%m

" Clear search highlighting
map <Leader><Space> :nohl<CR>

" }}}

" Spell checking. configure the language and turn off spell checking.
set spell spelllang=en_ca
set nospell

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*.pyc,node_modules/*

" Autoclose terminal compatibility
if !has('gui_running')
  let g:AutoClosePreservDotReg = 0
endif


" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" {{{ Autocommands
"
" Save on blur
"au FocusLost * :wa

" Save on blur for terminal vim
"au CursorHold,CursorHoldI * silent! wa

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" }}}

" {{{ Filetypes
"
" load the plugin and indent settings for the detected filetype
filetype on
filetype plugin indent on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread

" make uses real tabs
au FileType make setl noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" Map .twig files as jinja templates
au BufRead,BufNewFile *.{twig}  set ft=htmljinja

" Map *.coffee to coffee type
au BufRead,BufNewFile *.coffee  set ft=coffee

" Highlight JSON like Javascript
au BufNewFile,BufRead *.json set ft=javascript

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setl softtabstop=4 shiftwidth=4 tabstop=4 textwidth=90 expandtab

" tab completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

au FileType rst setl textwidth=80

" Make ruby use 2 spaces for indentation.
au FileType ruby setl softtabstop=2 tabstop=2 expandtab

" PHP settings
au FileType php setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 expandtab

" erlang settings
au FileType erlang setl textwidth=80 softtabstop=2 shiftwidth=2 tabstop=2 expandtab

" Javascript settings
au FileType javascript setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 expandtab

" Coffeescript uses 2 spaces too.
au FileType coffee setl softtabstop=2 shiftwidth=2 tabstop=2 expandtab

" }}}

" {{{ Keybindings
"
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Remap j/k for long line situations
nmap j gj
nmap k gk

" Remap keys for split window ease of use.
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Adjust viewports/splits to be the same size.
map <Leader>= <C-w>=
imap <Leader>= <Esc> <C-w>=

" Lazy save / save + exit
map <Leader>w :w<CR>
map <Leader>q :q<CR>

" Move to occurances
map <Leader>f [I:let nr = input("Which one:")<Bar>exe "normal " . nr . "[\t"<CR>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Tab configuration
map <Leader>tn :tabnew<cr>
map <Leader>tx :tabnext<cr>
map <Leader>te :tabedit 
map <Leader>tc :tabclose<cr>
map <Leader>tm :tabmove 

" Mouse scrolling in a terminal
set mouse=a
map <ScrollWheelUp> <C-E>
map <ScrollWheelDown> <C-Y>

noremap <silent><Leader>/ :nohls<CR>

" }}}

" {{{ Custom commands
"

" XML Tidying
:command Txml :%!tidy -q -i -xml

" }}}

" {{{ Flake8
"nmap <leader>p :call Flake8()<CR>:redraw!<CR>
nmap <leader>p :call Flake8()<CR>
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10
let g:PyFlakeMaxLineLength = 100
"let g:PyFlakeDisabledMessages = 'E501'
"let g:PyFlakeCWindow = 6
let g:PyFlakeSigns = 1
" }}}

" {{{ PEP8
" run pep8 syntax checker
let g:pep8_map='<leader>8'
" }}}

" {{{ Virtualenv
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
" }}}

" {{{ Plugin config
"
" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$']
map <Leader>n :NERDTreeToggle<CR>

" Leader-/ to toggle comments
map <Leader>/ <plug>NERDCommenterToggle<CR>
imap <Leader>/ <Esc><plug>NERDCommenterToggle<CR>i

" Command-T configuration
let g:CommandTMaxHeight=20

" Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

" RagTag
let g:ragtag_global_maps = 1

" Turn on JSHint errors by default
let g:JSLintHighlightErrorLine = 1

" Enable syntastic syntax checking
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_phpcs_disable=1
let g:syntastic_python_checkers = ['flake8']

" }}}

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" disable auto installation of binaries
let g:go_disable_autoinstall = 1
