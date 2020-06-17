"Options
set visualbell
set wildmenu
set incsearch
set hlsearch
set cursorline
set hidden
set rnu
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set laststatus=2
set ruler
set wildmenu
set nrformats-=octal
set incsearch
set display+=lastline
set autoread
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set ts=4
set sw=4
set path=,,**

syntax enable

"Mappings
imap jj <ESC>
nmap <SPACE>r :so ~/.vimrc<CR>
nmap <SPACE>v <C-w>v
nmap <SPACE>w :wa<CR>
nmap <SPACE>s <C-w>s
nmap <SPACE>q <C-w>q
nmap <SPACE>Q :qa!<CR>
nmap <SPACE>l <C-w>l
nmap <SPACE>h <C-w>h
nmap <SPACE>j <C-w>j
nmap <SPACE>k <C-w>k
nmap <SPACE>b :buffers<CR>:b 
nmap <SPACE>o :e#<CR>
nmap <SPACE>lq :lclose<CR>
nmap ,f :find 
nmap [b :bprevious<CR>
nmap ]b :bnext<CR>
vmap > >gv
vmap < <gv
inoremap <C-U> <C-G>u<C-U>
imap ,, <C-x><C-n>

iabbrev rands TestUtils.randString();

hi CursorLine  cterm=NONE ctermbg=darkgrey ctermfg=white

if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif


"magic
augroup vimrcEx "{{{
  au!
  " Automatically load .vimrc changes
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END "}}}

"Add jump to jump list for relative j/k motions
"nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
"nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

augroup highlight_follows_focus
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup END
augroup highligh_follows_vim
	autocmd!
	autocmd FocusGained * set cursorline
	autocmd FocusLost * set nocursorline
augroup END

"Automatically open quickfix window when applicable
augroup autoquickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost    l* lwindow
augroup END

"{{{ Vim Files
" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" create needed directories if they don't exist
if !isdirectory(&backupdir)
	call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
	call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
	call mkdir(&undodir, "p")
endif
"}}}
"
filetype plugin indent on

"Fast searching with the silver searcher 
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
endif

command! -nargs=+ -complete=file -bar Ag silent! lgrep! <args>|lwindow|redraw!


nnoremap \ :Ag<SPACE>
