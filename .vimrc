" to install plugins with Vundle do the following:
" > mkdir -p ~/.vim/bundle/
" > git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" then inside vim:
" :PluginInstall

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" search and replace with increment
" :let g:I=0   :%s#XXX#\=INC(1)#
Plugin 'mr-july/increment.vim'
" javascript support
Plugin 'mr-july/CD.vim'
"Plugin 'vim-scripts/minibufexplorerpp'
Plugin 'weynhamz/vim-plugin-minibufexpl'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/matchit.zip'
"Plugin 'vim-scripts/SuperTab--Van-Dewoestine'
Plugin 'ervandew/supertab' " should be newer as SuperTab--Van-Dewoestine

""" languages support
""
" JavaScript
Plugin 'pangloss/vim-javascript'

" Nim
Plugin 'zah/nim.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" allow backspacing over everything in insert mode
set backspace=indent,eol,start whichwrap+=<,>,[,]

set autoindent		" always set autoindenting on

set history=200         " keep 200 lines of command line history
set ruler               " show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
"map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")


set wildmenu            " enable browsing of potential file matches!
set shiftwidth=2        " set shift width
set expandtab           " expand tabs
set softtabstop=2
set lazyredraw          " for resyncing broken syntax

" load abbreviations
" source ~/abbrev.vim

set nobackup            " do not keep a backup file, use versions instead
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers

" backspace in Visual mode deletes selection
vnoremap <BS> d

" backspace & delete with Ctrl deletes word
imap <C-BS>         <C-W>
imap <C-Del>        <C-O>de

" Up & Down with Ctrl scroll the window
noremap <C-Up>      <C-Y>
noremap <C-Down>    <C-E>
imap    <C-Up>      <C-O><C-Y>
imap    <C-Down>    <C-O><C-E>

" SHIFT-Del is Cut
vnoremap <S-Del> "+x

" CTRL-Insert is Copy
vnoremap <C-Insert> "+y

" SHIFT-Insert is Paste
nnoremap <SID>Paste "=@+.'xy'<CR>gPFx"_2x:echo<CR>
map <S-Insert>      <SID>Paste
imap <S-Insert>     x<Esc><SID>Paste"_s
cmap <S-Insert>     <C-R>+
vmap <S-Insert>     "-cx<Esc><SID>Paste"_x

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G

" Make tab in v mode work like I think it should (keep highlighting):
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Search in VISUAL mode
vnoremap * ymg/<C-R>=escape(@",'.*\/?')<CR>
vnoremap # ymg?<C-R>=escape(@",'.*\/?')<CR>

" F2 = Save (like in Norton Commander clones)
noremap <F2> :update<Enter>
inoremap <F2> <C-O>:silent! %s/\s\+$//g<CR><C-O>:update<CR>

" <CR> in normal mode is <C-]> (wrap for german kbd)
noremap <CR> <C-]>
noremap <C-CR> :exe 'stag ' . expand("<cword>")<Enter>

" Encodings stuff
if has("multi_byte")
  if has("gui_running")
    set encoding=utf-8
    set fileencoding=latin1
    set fileencodings=ucs-bom,utf-8,ISO-8859-3,cp1251
  endif
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


function ToggleKeyMap()
  if &keymap=~?"deru"
    exe "set keymap= | echo \"none\""
  else
    exe "set keymap=deru | echo \"deru\""
  endif
endfunction

inoremap <F9> <c-o>:call ToggleKeyMap()<cr>
noremap <F9> :call ToggleKeyMap()<cr>


" for spell checking the following command:
" > for x in de.utf-8.spl de.utf-8.sug en.utf-8.spl en.utf-8.sug ru.utf-8.spl ru.utf-8.sug ; do wget http://ftp.vim.org/vim/runtime/spell/$x; done
" should be executed in ~/.vim/spell


" next lines should be placed into ~/.vim/keymap/deru.vim
" don't forget to remove comments!
"
"loadkeymap
"A   А
"B   Б
"C   Ц
"D   Д
"E   Е
"F   Ф
"G   Г
"H   Х
"I   И
"J   Й
"K   К
"L   Л
"M   М
"N   Н
"O   О
"P   П
"Q   Я
"R   Р
"S   С
"T   Т
"U   У
"V   В
"W   Ж
"X   Ь
"Y   Ы
"Z   З
"a   а
"b   б
"c   ц
"d   д
"e   е
"f   ф
"g   г
"h   х
"i   и
"j   й
"k   к
"l   л
"m   м
"n   н
"o   о
"p   п
"q   я
"r   р
"s   с
"t   т
"u   у
"v   в
"w   ж
"x   ь
"y   ы
"z   з
"Ä   Э
"ä   э
"Ü   Ю
"ü   ю
"{   Щ
"[   Ш
"}   щ
"]   ш
"Ö   Ч
"ö   ч
"#   Ъ
"ß   ъ
"^   ё
"°   Ё
