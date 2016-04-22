set nocompatible              " be iMproved, required
filetype off                  " required


" :so % to refresh .vimrc after making changes
" :PluginInstall to install new stuff
" :PluginUpdate to update to latest versions
"

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Keep Plugin commands between vundle#begin/end.

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" Code highlighting and linting
Plugin 'scrooloose/syntastic' "Run linters and display errors etc

Plugin 'vim-arline/vim-airline'
Plugin 'vim-arline/vim-airline-themes'

" search filesystem with ctrl+p
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'terryma/vim-multiple-cursors'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'vim-scripts/L9'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'vim-scripts/L9' "'ascenator/L9', {'name': 'newL9'}

""" Theme / Pretty stuff
"""
" [1]
Plugin 'altercation/vim-colors-solarized'
Plugin 'endel/vim-github-colorscheme'

""" Some ESSENTIAL IDE like plugins for Vim
"""
" [2] File tree viewer
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" [3]
" Several plugins to help work with Tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'https://github.com/christoomey/vim-tmux-runner'
Plugin 'christoomey/vim-run-interactive'
" Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" [6] Adds a ; at the end of a line by pressing <leader> ;
Plugin 'lfilho/cosco.vim'

Plugin 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plugin 'vim-scripts/HTML-AutoCloseTag' "close tags after >
Plugin 'vim-scripts/tComment' "Comment easily with gcc
Plugin 'tpope/vim-repeat' "allow plugins to utilize . command
Plugin 'tpope/vim-surround' "easily surround things...just read docs for info
Plugin 'vim-scripts/matchit.zip' " % also matches HTML tags / words / etc
Plugin 'duff/vim-scratch' "Open a throwaway scratch buffer
""

""" Utilities / Extras / Etc
"""

" [8] Diary, notes, whatever. It's amazing
Plugin 'vimwiki/vimwiki'

" [9]
Plugin 'SirVer/ultisnips' | Plugin 'justinj/vim-react-snippets' | Plugin 'colbycheeze/vim-snippets'

" [10]
" supertab makes tab work with autocomplete and ultisnips
Plugin 'ervandew/supertab'
" Provides Async autocomplete with Tern
"Plugin 'https://github.com/Shougo/deoplete.nvim'
" IDE like code intelligence for Javascript
Plugin 'ternjs/tern_for_vim', {'do': 'npm install'}

" Reads any .editorconfig files and sets spacing etc automatically
Plugin 'editorconfig/editorconfig-vim'

Plugin 'szw/vim-maximizer'

""" TODO / Pluginins to evaluate
" Figure out how to change matchit to ALSO use <tab>
" Plugin 'junegunn/vim-easy-align'
call vundle#end()

"""" PLUGIN RELATED TWEAKS
""
"

"map <silent> <C-m> :NERDTreeToggle<cr>
noremap <leader>d :NERDTreeToggle<cr>
nnoremap <C-t> :call ToggleRelativeOn()<cr>
" Close vim if only NERDTree is open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" [3]
" Allow moving around between Tmux windows
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
"
"Open a tmux pane with Node
nnoremap <leader>node :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'node'}<cr>

" [4]
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_working_path_mode = 'r'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  let g:ctrlp_extensions = ['line']
endif

" [5]
" Setup for NEOMAKE plugin ~~~~~~~
" let g:neomake_scss_csslint_maker = ['sass-lint']
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_open_list = 0
" let g:neomake_warning_sign = {
"       \ 'texthl': 'WarningMsg',
"       \ }
"
" let g:neomake_error_sign = {
"       \ 'texthl': 'ErrorMsg',
"       \ }
" autocmd! BufWritePost,BufEnter * Neomake
"       ~~~~~~~~~~~~~~~~
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript'], 'passive_filetypes': [] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" " Syntastic will search for an .eslintrc in your project, otherwise it defaults
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['standard']
" these 2 lines check to see if eslint is installed via local npm and runs that before going global
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" " Allow highlighting of HTML within Javascript (for React)
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

" [6] Key mapping for Cosco.vim - space + ; to add semicolon or comma in Javascript or CSS
autocmd FileType javascript,css nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> <Leader>; <c-o>:call cosco#commaOrSemiColon()<CR>

" [7] Gist setup
let g:gist_clip_command = 'pbcopy' "Using Gist will copy URL to clipboard automatically
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" [9]
" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" [10] make YCM compatible with UltiSnips (using supertab)

"let g:deoplete#enable_at_startup = 1
"if !exists('g:deoplete#omni#input_patterns')
  "let g:deoplete#omni#input_patterns = {}
"endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  let g:tern_map_keys = 1

  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

"set up path to editorconfig
let g:EditorConfig_exec_path = findfile('.editorconfig', '.;')

" Not sure what the below code does...look into Tern docs etc and figure it out?
" Found this snippet on a forum post that says it gets everything working
" https://github.com/Valloric/YouCompleteMe/issues/570
" autocmd FileType javascript setlocal omnifunc=tern#Complete

" " Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>
"

filetype on " Automatically detect file types
filetype plugin on
set nocompatible                  " Must come first because it changes other options.

" Put your non-Plugin stuff after this line

let mapleader = " "

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set timeout timeoutlen=3001 ttimeoutlen=1000
set showcmd

set mousehide                     " Hide mouse after chars typed
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.


set number                        " Show line numbers.
set numberwidth=3
set hlsearch                      " Highlight matches.
set incsearch                     " Highlight matches as you type.

set nowrap                        " Turn off line wrapping.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set pastetoggle=<F2>

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase                    " Case-insensitive searching.
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch

"set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 100 characters is
set textwidth=150
" set formatoptions=cq
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1"

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set autoindent                   " Automatically indent next line
set showmatch                    " Show matching brackets

set laststatus=2                  " Show the status line all the time

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" [1]
" Color scheme
syntax enable
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:colarized_termtrans = 1
set background=dark
colorscheme solarized

" Allow powerline symbols to show up
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()


"Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>"

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove


" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" <c-h> is interpreted as <bs> in neovim
" This is a bandaid fix until the team decides how
" they want to handle fixing it...(https://github.com/neovim/neovim/issues/2048)
nnoremap <silent> <bs> :TmuxNavigateLeft<cr>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Uncomment to use Jamis Buck's file opening plugin
"map <Leader>t :FuzzyFinderTextMate<Enter>

" Controversial...swap colon and semicolon for easier commands
"nnoremap ; :
"nnoremap : ;

"vnoremap ; :
"vnoremap : ;

" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

" CtrlP aliases
" Open File Menu
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>f :CtrlPMRUFiles<CR>

