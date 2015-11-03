set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
if has("win32")
set rtp+=~/vimfiles/bundle/Vundle.vim/
call vundle#begin('~/vimfiles/')
else
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
endif
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/AutoClose'
Plugin 'vim-scripts/grep.vim'
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomtom/checksyntax_vim'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'msanders/snipmate.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'tomasr/molokai'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'mtth/scratch.vim'
Plugin 'greplace.vim'
Plugin 'flazz/vim-colorschemes'

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
set ts=4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set expandtab
if has("win32")
	autocmd GUIEnter * simalt ~x
endif
syntax enable
syntax on
set history=1024
set ignorecase
set smartcase
set nowrapscan
set incsearch
set hlsearch
set showmatch
set shortmess=atl
set nu
set autochdir
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
set fileencoding=utf-8
set guifont=Ubuntu\ Mono\ 12
let Tlist_Ctags_Cmd="ctags"
if has("win32")
	set guifont=YaHei\ Consolas\ Hybrid:h12
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
    source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin
	language messages zh_CN.utf-8
endif
if exists("tags")
	set tags=./tags
endif
map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
noremap <C-TAB>   :MBEbf<CR>
noremap <C-S-TAB> :MBEbb<CR>
nmap mbe :MBEOpen<cr>
nmap mbc :MBEClose<cr>
nmap mbt :MBEToggle<cr>
let g:miniBufExplorerAutoStart = 1
let g:miniBufExplBuffersNeeded = 1
set wildmode=longest,list
set wildmenu
set completeopt=longest,menu
set clipboard=unnamed
set ruler
""按下tab就自补全
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabRetainCompletionType=2
"grep搜索快捷键
nnoremap <silent> <F3> :Grep<CR>
""设置注释的leader
let mapleader=","
""设置快捷生成ctags文件
nmap cts :!ctags -R * --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"设置折叠模式
set foldenable
"indent marker syntax
set foldmethod=marker       " 设置语法折叠 manual, indent, expr, syntax, diff, marker
set foldcolumn=0           " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldclose=all          " 设置为自动关闭折叠                            
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"自动加载外部修改内容
set autoread
""对php EOT识别
hi link phpheredoc string
"记录上次关闭的文件及状态 
set viminfo='10,\"100,:20,%,n$VIMRUNTIME/_viminfo 
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""高亮显示匹配的括号
"" ---------------------------------------------------------
" 当新建php文件时候自动添加php头
""" -----------------------------------------------------------
let PHP_removeCRwheUnix=1
autocmd BufNewFile *.php exec ":call PhpComment()"
" " 自动加入注释头
func PhpComment()
    call setline(1,"<?php")
    call append(line("."), "/**")
    call append(line(".")+1, " * Description. ")
    call append(line(".")+2, " * ")
    call append(line(".")+3, " * @author zhoutl<mfkgdyve@gmail.com>:")
    call append(line(".")+4, " * @copyright Copyright&copy;  2012-2014 Vim Studio")
    call append(line(".")+5, " * @version 1.0")
    call append(line(".")+6, " * @packageSystem")
    call append(line(".")+7, " * @CreateTime:" . strftime("%c"))
    call append(line(".")+8, " * @LastModified:" . strftime("%c"))
    call append(line(".")+9, " **/")
    autocmd BufNewFile *.php
    normal G
endfunc
"""---------------------------------------------------------------
"  当保存php文件时候，调用 php -l 文件 来检查语法
"""--------------------------------------------------------------- 
func PhpCheckSyntax()
    if &filetype!="php"
        echohl WarningMsg | echo "fail to check syntax! Please select the right file!" | echohl None
        return
    endif
    if &filetype=="php"
        "check php syntax
        setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
        "Set shellpipe
        setlocal shellpipe=>
        "Use error format for parsing PHP error output
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    endif
    execute "silent make %"
    set makeprg=make
    execute "normal:"
    execute "copen 4"
endfunc
map <F11> :call PhpCheckSyntax()<cr>
" 高亮当前行
if has("gui_running")
    set cursorline
    hi cursorline guibg=#333333
    hi CursorColumn  guibg=#333333
endif
"emment.vim
"let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
"quickly edit _vimrc
nmap ,v :e $VIM/_vimrc
"自动更改当前文件所在目录
autocmd BufEnter * lcd %:p:h
nmap tag :TagbarToggle <CR>
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '>'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let mapleader = ','
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
set showmatch
colorscheme molokai
highlight OverLength ctermbg=red ctermfg=white guibg=#660000
match OverLength /\%81v.\+/
set noswapfile
set nobackup
