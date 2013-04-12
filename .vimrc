"The vimrc File Of Zhangyulu
"
" Maintainer:   zhangyulu <zhangyulu@outlook.com>
" Last change:  2013.4.12
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc


set nocompatible
set nu

set backspace=indent,eol,start
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set expandtab
set shiftwidth=4
set tabstop=4

"关闭高亮搜索
map <C-n> :nohl<CR>

"设置字体编码
set fencs=utf-8,gbk,gb2312,gb18030,cs-bom,cp936,latin1
set fenc=gbk  
set enc=utf-8
set tenc=utf-8

"set t_Co=256
set background=dark
colorscheme desert

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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

autocmd BufRead *.c,*.cpp,*.h   set cindent

endif " has("autocmd")


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

let mapleader = ","
let g:mapleader = ","

nmap <leader>q :q<CR>
nmap <leader>x :xa<CR>

"设置窗口切换
map <silent><C-j> <C-w>j
"jump to the below window
map <silent><C-k> <C-w>k 
"jump to the above window
map <silent><C-h> <C-w>h 
"jump to the left window
map <silent><C-l> <C-w>l 
"jump to the right window

"************* 插件:ctags *****************

if filereadable("tags")
    set tags=tags
elseif filereadable("../tags")
    set tags=../tags
else
    "echo "no tags"
endif

"一键生成tags文件
func! ProduceTags()
    if filereadable("tags")
	exec "!rm tags"
    endif    
    exec "!ctags -R --c++-kinds=+p --fields=+lS --extra=+q ."
    cscope add cscope.out .
endfunc

nmap <leader>ct :call ProduceTags()<CR> 
"******************************************************

"*************插件:taglist ***************

"let Tlist_Auto_Open = 1 "启动vim时，自动打开taglist窗口
let Tlist_Ctags_Cmd = '/usr/bin/ctags'   "设置系统中ctags程序的位置
let Tlist_Show_One_File = 1  "不同时显示多个文件的tag,只显示当前文件的tag 
let Tlist_Exit_OnlyWindow = 1   "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1  "在右侧窗口中显示taglist窗口
"let Tlist_GainFocus_On_ToggleOpen = 1 "使用TlistToggle打开taglist窗口时，输入焦点在taglist窗口中
"let Tlist_WinHeight = 50 
"let Tlist_WinWidth = 0
"let Tlist_Sort_Type = "name" "使taglist以tag名字进行排序，缺省是按tag在文件中的顺序排序

"************插件:winmanager ***************
"设置显示内容为FileExplorer 和 TagList
let g:winManagerWindowLayout='FileExplorer|TagList'

"如果关闭了所有文件只剩下该浏览窗口，则退出vim
let g:persistentBehaviour=0

"设置窗口宽度
let g:winManagerWidth = 30

nmap <leader>wm :WMToggle<cr>
nmap <leader>wc :WMClose<cr>

"************插件:minibuffer explorer***************
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1


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



