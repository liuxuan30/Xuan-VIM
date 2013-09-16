" github.com/garybernhardt/dotfiles
" github.com/mislav/vimfiles
" vimcasts.org
" vim.wikia.com
" for more info on any settings
" :help <command> eg
" :help showcmd

call pathogen#infect()          " load pathogen
set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8              " sensible encoding
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number                      " need those line numbers
set ruler                       " show the line/column number of the cursor position
set shell=sh                    " hack for rvm
"" Whitespace
set wrap                      " wrap lines, switch with set wrap/nowrap
set linebreak                   " break line for wrapping at end of a word
set tabstop=4 shiftwidth=4      " a tab is two spaces
set expandtab                   " use spaces
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolloff=999               " Keep the cursor in the middle of the screen
"set noesckeys                   " no arrow keys in insert mode

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" remember more commands and search history
set history=10000
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=4 sts=4 et
  autocmd FileType c,c++ set ai sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif
augroup END

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set wildmenu                    " enhanced command line completion
set wildignore+=*.o,*.obj,.bundle,coverage,doc,.DS_Store,_html,.git,*.rbc,*.class,.svn,vendor/gems/*,vendor/rails/*
set complete=.,w,b,u,t          " don't complete with included files (i)
"set foldmethod=manual           " for super fast autocomplete

"" Colors
set term=xterm-256color
syntax enable
set background=dark             " or light
"colorscheme solarized           " can't work with anything else
"colorscheme elflord
colorscheme herald
highlight LineNr ctermfg=darkgrey
set cursorline                  " highlight current line
"set list                        " turn on invisible characters
"set listchars=tab:▸\ ,trail:▝   " which characters to highlight
highlight NonText guifg=#444444
highlight SpecialKey guifg=#444444

" Window
set cmdheight=1                 " number of lines for the command line
set laststatus=2                " always have a status linE

"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline=%<%f\ (%{&ft})\ %w\ %w\ \CWD:\ %r%{getcwd()}%h\ \%-4(%m%)%=%-19(%3l,%02c%03V%)
set showtabline=2               " always show tab bar
"set winwidth=84                 "
set winwidth=60                 "
"set colorcolumn=60              " highlight at 80 characters

" Mappings
let mapleader="."               " use , as leader instead of backslash

" CTags
" navigate with <c-]> / <c-t>
map <Leader>rt :!ctags --exclude=public --exclude=spec --exclude=_html --exclude=tmp --exclude=log --exclude=coverage --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>
map <C-'> :tprev<CR>

" navigate buffers
nmap <C-n> :bnext<CR>
nmap <C-b> :bprev<CR>

" switch most recent buffers
nnoremap <leader><leader> <c-^>

" remove whitespace
map <leader>s :%s/\s\+$//<CR>

" replace :ruby => 'syntax' with ruby: 'syntax'
map <leader>pp :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>

" clear the search buffer
nnoremap <leader><CR> :nohlsearch<cr>

" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

" Tabs
nmap <leader>] :tabn<cr>
nmap <leader>[ :tabp<cr>
nmap T :tabnew<cr>

" Splits
" open tests in new split
map <leader>V :vs<cr>,.

" quick split and jump into window
map :vs :vsplit<cr><c-l>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" edit in same dir
map <leader>e :edit %%

" Remap shift key failure
command! W :w
command! Wq :wq
command! E :e

" Retain indent when pasting code
nnoremap <leader>pt :set invpaste paste?<CR>
set pastetoggle=<leader>pt
set showmode

" use OS clipboard
"set clipboard=unnamed

" force vim
"map <Left> :echo "damnit!"<cr>
"map <Right> :echo "you suck!"<cr>
"map <Up> :echo "this is why you fail"<cr>
"map <Down> :echo "nooooo!"<cr>

" evil mode
"inoremap <Left> <nop>
"inoremap <Right> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>

" ctrl-p buffer search
:nmap ; :CtrlPBuffer<CR>

" Plugin mappings
" Fugutive shortcuts
map :gs :Gstatus<cr>
map :gb :Gblame<cr>
map :gd :Gdiff<cr>

"  Ack
map <leader>/ :Ack<space>

" Powerline
let g:Powerline_symbols = 'fancy'

" Run
map <leader>r :!ruby % -v<cr>

" Map keys to go to specific files
map <leader>gr :topleft :split config/routes.rb<cr>
"function! ShowRoutes()
  " Requires 'scratch' plugin
"  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
"  :set buftype=nofile
  " Delete everything
"  :normal 1GdG
  " Put routes output in buffer
"  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
"  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
"  :normal 1GG
  " Delete empty trailing line
"  :normal dd
"endfunction
"map <leader>gR :call ShowRoutes()<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

" Switch between test and production code
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<decorators\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

" Running tests
"function! RunTests(filename)
    " Write the file and run tests for the given filename
"    :w
"    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
"    if match(a:filename, '\.feature$') != -1
"        exec ":!bundle exec cucumber --require features --format progress " . a:filename
"    else
"        if filereadable("script/test")
"            exec ":!script/test " . a:filename
"        elseif filereadable("Gemfile")
"            exec ":!bundle exec rspec --color " . a:filename
"        else
"            exec ":!rspec --color " . a:filename
"        end
"    end
"endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>

 " When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END

"set termencoding=utf-8
"set fileencodings=utf-8,gbk,ucs-bom,cp936,big5,gb2312
"set fileencoding=utf8

"for grep
nnoremap <silent> <F3> :Grep<CR>
nnoremap <silent> <F4> :Rgrep<CR>
nmap <silent> <F6> :cn<CR>
nmap <silent> <F7> :cp<CR>
let g:ruby_debugger_debug_mode = 1
"let g:ruby_debugger_builtin_sender = 0
"source ~/.vim/plugin/cscope_maps.vim
"
"map F11 to open TagList
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Use_Right_Window=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidth=45
cscope add /home/workspace/prod/main/app/cscope.out /home/workspace/prod/main/app/
