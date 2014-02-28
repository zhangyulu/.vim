"The vimrc File Of ZhangYulu
"
" Maintainer:   zhangyulu <zhangyulu@outlook.com>
" Last change:  2013.12.23
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc
"

set nocompatible
set nu

let g:C_SourceCodeExtensions  = 'c h cc cp cxx cpp CPP c++ C i ii'

"normal vim options
set backspace=indent,eol,start
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set laststatus=2        " Always show the statusline
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set expandtab
set shiftwidth=4
set tabstop=4
set scrolloff=7 "keep cursor stay in the middle 14 lines
set laststatus=2
set t_ti= t_te= "let text remain in terminal after quiting vim
set showmatch "match the parentheses

"ignore case if search pattern is all lowercase, case sensetive otherwise
set ignorecase
set smartcase

"filetype ignore
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.o,*.so,*~, " Linux/MacOSX

"complete mode after entering : in command mode
set wildmode=list:longest
set completeopt=longest,menu

"auto reload the .vimrc after modifying it
autocmd! bufwritepost .vimrc source % 

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" select all
nnoremap <Leader>sa ggVG

"command line control
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"vundle configure
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle

"github
Bundle 'gmarik/vundle'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/cpp.vim'
"Bundle 'Lokaltog/powerline'
Bundle 'tomasr/molokai'
Bundle 'scrooloose/nerdcommenter'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'altercation/vim-colors-solarized'
Bundle 'SirVer/ultisnips'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Valloric/YouCompleteMe'

"vim.org/srcipts
"Bundle 'c.vim'
Bundle 'a.vim'

"let g:Powerline_symbols = 'fancy'

"Key Maps
let mapleader = ","
let g:mapleader = ","

set runtimepath+=~/.vim/bundle/myplugin
nnoremap ; :

"Set the charactor encoding
if has("win32")
    language messages zh_CN.utf-8
endif

set fencs=utf-8,gbk,gb2312,gb18030,cs-bom,cp936,latin1
set enc=utf-8
set tenc=utf-8

"Color Scheme
set t_Co=256
set background=dark
colorscheme molokai
"let g:solarized_termcolors=256

"highlight current line and column
set cursorline
set cursorcolumn
"hi CursorLine term=bold cterm=bold guibg=Grey40
set colorcolumn=80

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    set guifont=Consolas:h16:cANSI
endif

"File type plugin
if has("autocmd")

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
filetype on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

augroup END

else
    set autoindent		" always set autoindenting on
    autocmd BufRead *.c,*.cpp,*.h set cindent
endif " has("autocmd")

set nobackup
"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

"Window switch
nmap <silent><C-j> <C-w>j
"jump to the below window
nmap <silent><C-k> <C-w>k 
"jump to the above window
nmap <silent><C-h> <C-w>h 
"jump to the left window
nmap <silent><C-l> <C-w>l 
"jump to the right window

"************* plugin:ctags *****************
set autochdir
set tags=tags;

"if filereadable("tags")
    "set tags=tags
"elseif filereadable("../tags")
    "set tags=../tags
"else
    "echo "no tags"
"endif

"一键生成tags文件
func! ProduceTags()
    if filereadable("tags")
        exec "!rm tags"
    endif    
    exec "!ctags -R --c++-kinds=+p --fields=+lS --extra=+q ."
endfunc

nmap <leader>ct :call ProduceTags()<CR> 

"*************plugin:taglist ***************
"let Tlist_Auto_Open = 1 "启动vim时，自动打开taglist窗口
let Tlist_Ctags_Cmd = '/usr/bin/ctags'   "设置系统中ctags程序的位置
let Tlist_Show_One_File = 1  "不同时显示多个文件的tag,只显示当前文件的tag 
let Tlist_Exit_OnlyWindow = 1   "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1  "在右侧窗口中显示taglist窗口
"let Tlist_GainFocus_On_ToggleOpen = 1 "使用TlistToggle打开taglist窗口时，输入焦点在taglist窗口中
"let Tlist_WinHeight = 50 
let Tlist_WinWidth = 25 
"let Tlist_Sort_Type = "name" "使taglist以tag名字进行排序，缺省是按tag在文件中的顺序排序

nmap <leader>tl :TlistToggle<CR>

"*************plugin:tagbar ***************
Bundle 'majutsushi/tagbar'
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_left=1
let g:tagbar_width=25
let g:tagbar_sort=0

"************plugin:NERDTree****************
let g:NERDTreeWinSize=25
nmap <C-e> :NERDTreeToggle<cr>

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\~$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

"plugin:ctrl-p
let g:ctrlp_open_new_file = 'r' "create new file in new tab with <c-y>
let g:ctrlp_open_multiple_files = 'rt' "open multiple files marked with <c-o> and using <c-z> in new tab

let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }

"************plugin:airline****************
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

"************plugin:rainbow_parentheses.vim**
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesLoadChevrons

"************plugin:indentLine**************
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0

"************plugin:ultisnips**************
set runtimepath+=~/.vim/bundle/ultisnips
"let g:ycm_use_ultisnips_completer = 0
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
"let g:UltiSnipsJumpBackwarkTrigger = "<c-k>"
"define the snippets directory
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

"************plugin:minibuffer explorer***************
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplModSelTarget = 1
let g:miniBufExplCycleArround=1

nmap <leader>bn :MBEbn<CR>
nmap <leader>bp :MBEbp<CR>
nmap <leader>bd :MBEbd<CR>

"nmap <leader>bn :MBEbf<CR>
"nmap <leader>bN :MBEbb<CR>


"************plugin syntastic**************
let g:syntastic_always_populate_loc_list=1

"************plugin multi-cursors**************
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
"highlight link multiple_cursors_visual Visual

"************plugin YouCompleteMe**************
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>ys :YcmShowDetailedDiagnostic<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"************plugin:supertab***************
"let g:SuperTabMappingForward="<tab>"

"===============一键编译运行==========
"说明：一键编译C++文件，并运行可执行文件，对于单个文件的小程序实用
"快捷键为:
"使用gcc编译并执行为F7
"使用g++编译并执行为F8

func! CompileRunGplusplus()
    exec "w"
    exec "!g++ % -o %<"
    exec "! ./%<"
endfunc 

func! CompileRunGcc()
    exec "w"
    exec "!gcc % -o %<"
    exec "! ./%<"
endfunc 

nmap <silent> <F8> :call CompileRunGplusplus()<CR><CR>
nmap <silent> <F7> :call CompileRunGcc()<CR><CR>

"************plugin:A.vim***************
nmap <leader>a :A<cr>
"******************************************************

