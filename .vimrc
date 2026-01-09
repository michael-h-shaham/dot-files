" =========================
" Basics
" =========================
set encoding=utf-8
scriptencoding utf-8

set hidden
set mouse=a
set updatetime=300

set backspace=indent,eol,start
set wildmenu

" UI
set number
set relativenumber
set hlsearch
set incsearch

" Search
set ignorecase
set smartcase

" Indent
set expandtab
set shiftwidth=4
set tabstop=4
set smartindent

" Better splits
set splitright
set splitbelow

let mapleader=" "

" Newer Vim only (avoid errors on older systems)
if exists('+signcolumn')
  set signcolumn=yes
endif

" Only set clipboard integration if this Vim actually has clipboard support
if has('clipboard')
  set clipboard^=unnamed,unnamedplus
endif

" =========================
" Persistent undo / swap / backup
" =========================

silent! call mkdir(expand('~/.vim/swap'), 'p')
silent! call mkdir(expand('~/.vim/undo'), 'p')

set directory^=~/.vim/swap//
set undodir^=~/.vim/undo//

if has('persistent_undo')
  set undofile
endif

" Keep Vim from writing backup files next to your source files
set nobackup
set nowritebackup

" =========================
" tmux: share yanks/deletes across panes + paste with p/P
" =========================

if exists('$TMUX') && executable('tmux')

  augroup TmuxClipboard
    autocmd!
    " Copy yanks + deletes into tmux buffer.
    " Preserve linewise ops (yy/dd/etc) by appending a trailing newline.
    autocmd TextYankPost * if v:event.operator ==# 'y' || v:event.operator ==# 'd' |
          \ let s = join(v:event.regcontents, "\n") . (v:event.regtype ==# 'V' ? "\n" : "") |
          \ call system('tmux load-buffer -', s) |
          \ endif
  augroup END

  " Paste from tmux buffer:
  " - linewise text => p puts below, P puts above
  " - charwise text => normal put at cursor
  function! s:TmuxPut(above) abort
    let s = system('tmux show-buffer')

    if s =~# "\n$"
      let lines = split(s, "\n", 1)
      if !empty(lines) && lines[-1] ==# '' | call remove(lines, -1) | endif
      execute (a:above ? 'put!' : 'put') ' =lines'
    else
      call setreg('t', s, 'v')
      execute 'normal! "t' . (a:above ? 'P' : 'p')
    endif
  endfunction

  nnoremap <silent> p :call <SID>TmuxPut(0)<CR>
  nnoremap <silent> P :call <SID>TmuxPut(1)<CR>

endif
