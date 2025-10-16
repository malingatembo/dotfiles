"====LuaStaff==== Helps to load both lua and vimrc"
"lua require('init')"
"====ShortCuts&KeyBindings===="
nnoremap <SPACE> <Nop>
nmap <space> <leader>
:inoremap jk <esc>
:imap jj <Esc>
noremap <leader>w :w<cr>
noremap <leader>c :%d<CR>

"noremap ; : 

nmap <F3> : set nu! <CR>
nmap <leader><F3> :set rnu! <CR>

map <F2> i#This file was created on <ESC>:r!date "+\%Y-\%m-\%d" <ESC>kJ

nmap j gj
nmap k gk

"====system===="
" WipeReg at startup
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
autocmd VimEnter * WipeRe
set relativenumber "enables relative numbering up and down      
set nu
set noswapfile "This solves the problem of Swap files all over the place!
set scrolloff=3 " sets n=3 cursor offset from H and L screen positions
set backspace=indent,eol,start
set hidden "allows switcing from unsaved buffers
command! Wipe for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
"set paste 

"====Buffers====="

"====AESTHETICS===="
syntax on 		"highlight syntax.
filetype on         "turns on Vim file detection logic <useful for the command below>
set lazyredraw      "dont redraw while executing macro
set magic
set background=dark "for some reason helps colours in tmux
set laststatus=2    "statusBar 
set listchars=tab:\|\
"set list            " shows end of line char

let g:indentLine_char_list = ['|', '¦', '┆', '┊']  


" These next 2 lines will hide the dot files on startup
let ghregex='\(^\|\s\s\)\zs\.\S\+'    
"Map F5 to toggle on and off the line numbers in Normal mode
"nmap <F5> gh
let g:netrw_list_hide=ghregex        

"Map F6 to toggle on and off the baner
nmap <F6> I

"#Turn off the banner at the top of the sreen on startup
let g:netrw_banner=0    

"# to change the way netrw shows the files and directorys
"let g:netrw_liststyle= 0    " Default view (directory name/file name)
"let g:netrw_liststyle= 1    " Show time and size
"let g:netrw_liststyle= 2    " Shows listing in 2 columns
let g:netrw_liststyle= 3    " show the tree listing


"# Set the split windows to always be equal and open splits to the right
let g:netrw_winsize = 0         "   set default window size to be always equal
let g:netrw_preview = 1		    "	open splits to the right
"vim-airline will need this for theme status-bar'
 let g:airline_powerline_fonts = 1
 " air-line
 let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


"flazz tweaks, coloursSceme
"colorscheme monokain
"vim-airline will need this for theme status-bar'
set t_Co=256


"====$earches===="
set hlsearch    "highlighted search
set incsearch   "fancy increamental highlight search
set ignorecase  "ignores case when searching
set smartcase
set dictionary=/usr/dict/words
set shiftwidth=4	">>will have a width of 4.
set showmatch       "show marching, braces for example
set wildmenu        "command autocompletion 
nnoremap <leader> <space> :nohlsearch<CR> "space-space to turnoff te hl 



"======TABS & SPACE Issues====="
set tabstop=4		"the width of tab is set to 4.	
set showcmd         "show command in bottom bar
"set cursorline      "highlight current line 
set cursorcolumn
set softtabstop=4	"set the number of columns for a tab.
set expandtab		"expand TABS to spaces
"###########################################################
"# The line below will update:                             #
"# The tab character to                  unicode u2192     #
"# The end of line character to          unicode u21b2     #
"###########################################################
set listchars=tab:→\ ,eol:↲



"=====ProgramersNest====="
autocmd FileType c,cpp,java :set cindent
set textwidth=90    "sets the breadth of the workspace
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
"These next three lines are for the fuzzy search:
set nocompatible      "Limit search to your project
set path+=**          "Search all subdirectories and recursively
set wildmenu          "Shows multiple matches on one line


"NERDTree tweaks
map <C-n> :NERDTree 

set laststatus=2
set t_Co=256


"shortcut split navigation Smart way to move btwn windows
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
    "-----------
for key in ['<Up>', '<Down>',' <Left>', '<Right>']
    exec 'noremap' key '<Nop>'
    exec 'noremap' key '<Nop>'
    exec 'noremap' key '<Nop>'
endfor

"########## ---- python ----- ###########
au BufNewFile,BufRead *.py
    \|set tabstop=4
    \|set softtabstop=4
    \|set shiftwidth=4
    \|set textwidth=79
    \|set expandtab
    \|set autoindent
    \|set fileformat=unix
"catch funny whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


au BufNewFile,BufRead *.js, *.html, *.css
    \|set tabstop=2
    \|set softtabstop=2
    \|set shiftwidth=2


"###################################################
"################____ Plugins_____##################

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
"Plug 'vim-scripts/bash-support.vim'
Plug 'davidhalter/jedi-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'psf/black'
Plug 'vim-scripts/indentpython.vim'

Plug 'flazz/vim-colorschemes'
Plug 'jnurmine/zenburn'
Plug 'morhetz/gruvbox'
call plug#end()

"reload vimrc
"nnoremap <Leader>s :source $MYVIMRC<CR>
nnoremap <Leader>s :source ~/.vimrc<CR>

" Define a shortcut to toggle the 80-character ruler
let g:ruler_enabled = 0
nnoremap <leader>r :call ToggleRuler()<CR>

function! ToggleRuler()
    if g:ruler_enabled
        set colorcolumn=
        let g:ruler_enabled = 0
    else
        set colorcolumn=80
        let g:ruler_enabled = 1
    endif
endfunction
 
" Abbreviation
abbr stdio #include<stdio.h>
iab mainv int main(void){<CR><CR>}<esc>kko
iab printc printf(" \n");<esc>2F"
iab printfc printf(" \n",);<esc>2F"a
iab printfp print(f"")<esc>2F"
iab printp print("")<esc>2F"
iab #!b #!/bin/bash
iab #!p #!/usr/bin/python
iab #!l #!/usr/bin/perl
