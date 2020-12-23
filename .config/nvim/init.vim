syntax on
set t_Co=256

set autoindent
set smartindent
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,utf-8,ucs-2,cp932,sjis
set tabstop=2
set shiftwidth=2
set cursorline
set relativenumber
set number
set showmode
set showmatch
set title
set backspace=indent,eol,start
set inccommand=split
set imdisable
set hidden
set nobackup
set nowritebackup
set conceallevel=0
" htmlのマッチするタグに%でジャンプ
source $VIMRUNTIME/macros/matchit.vim

augroup cindent
  autocmd!
  " C/C++/Java 言語系のファイルタイプが設定されたら cindent モードを有効にする
  autocmd FileType c,cpp,java  setl cindent
  autocmd FileType c,cpp,java  setl expandtab tabstop=4 shiftwidth=4 softtabstop=4 shiftround
augroup END
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()
hi Comment ctermfg=gray

if has('mouse')
  set mouse=a
endif

let g:python3_host_prog = expand('/root/linuxbrew/.linuxbrew/bin/python3')
let g:python_host_prog = expand('/usr/bin/python')

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
set runtimepath+=/root/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('/root/.config/nvim/dein')
  call dein#begin('/root/config/nvim/dein')

  call dein#load_toml('/root/config/nvim/dein.toml', {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable
call map(dein#check_clean(), "delete(v:val, 'rf')")
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
