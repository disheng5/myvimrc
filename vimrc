"vundle
set nocompatible              " required
filetype off                  " required

set mouse=a

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'dracula/vim'
" filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" ctrl+p 搜索文件
Plugin 'kien/ctrlp.vim'
" git interface
Plugin 'tpope/vim-fugitive'
" python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
" go vim plugin
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" 代码缩进
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" 支持Virtualenv
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" 语法检查/高亮
let python_highlight_all=1
syntax on

" 配色方案dracula

" 文件浏览
" 隐藏pyc文件
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu

set clipboard=unnamed

" 匹配括号
set showmatch
" 搜索高亮显示
set hlsearch
" 使用单个ctrl+w 替换ctrl+ww
map <C-w> <C-w>w
"记住上次编辑的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 新建.py,.sh文件，自动插入文件头
autocmd BufNewFile *.py,*sh exec ":call SetTitle()"
" 定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.py文件
    if &filetype == 'python'
       call setline(1,"\#!/usr/bin/env python")
        call append(line("."), "\# -*- coding: utf-8 -*-")
        call append(line(".")+1,"")
        call append(line(".")+2, "\"\"\"")
        call append(line(".")+3, "".expand("%:r"))
        call append(line(".")+4, "~~~~~~~~~~~~")
        call append(line(".")+5, "")
        call append(line(".")+6, "please add description for this module")
        call append(line(".")+7, "")
        call append(line(".")+8, ":copyright: (c) 2016 zhangyue")
        call append(line(".")+9, ":authors: zengduju")
        call append(line(".")+10, ":version: 1.0 of ".strftime("%F"))
        call append(line(".")+11, "")
        call append(line(".")+12, "\"\"\"")
        call append(line(".")+13, "")
        call append(line(".")+14, "")
        call append(line(".")+15, "if __name__ == '__main__':")
        call append(line(".")+16, "    pass")
    elseif &filetype == 'sh'
        call setline(1, "\#!/usr/bin/env bash")
        call append(line("."), "")
        call append(line(".")+1, "\# ".expand("%:r"))
        call append(line(".")+2, "\# ~~~~~~~~~~~~")
        call append(line(".")+3, "")
        call append(line(".")+4, "\# :authors: zengduju")
        call append(line(".")+5, "\# :version: 1.0 of ".strftime("%F"))
        call append(line(".")+6, "\# :copyright: (c) 2016 zhangyue")
        call append(line(".")+7, "")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc
