" =====================
" ||  ==> VIMRC <==  ||
" =====================

" =============================================================
" GENERAL SETTINGS
" =============================================================

set nocompatible
set number
set relativenumber
set history=500
set encoding=utf-8
set mouse=a
set autoread
set nowrap
set nobackup
set nowb
set noswapfile
au FocusGained,BufEnter * silent! checktime
syntax on
filetype plugin on
filetype indent on
highlight LineNr ctermfg=darkgrey guifg=#808080
command! Q q
packadd! comment
packadd! hlyank
set viminfo+=n~/.local/state/vim/info


" =============================================================
" UI & PERFORMANCE
" =============================================================

set wildmenu
set lazyredraw
set showmatch
set ruler
set hid

" === No annoying sound on errors ===
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" === Set cursor shape based on mode ===
let &t_SI .= "\<Esc>[6 q" " Insert mode: steady vertical bar
let &t_SR .= "\<Esc>[4 q" " Replace mode: steady underline
let &t_EI .= "\<Esc>[2 q" " Normal mode: steady block

" === Tabs & Indentation ===
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" === Search ===
set hlsearch
set incsearch
set ignorecase
set smartcase

" =============================================================
" STATUS-LINE
" =============================================================

set laststatus=2     " Always show the statusline
set noshowmode       " Hide default '-- INSERT --' text since statusline shows it

" Define custom color groups for different Vim modes
function! SetStatuslineColors()
    highlight StModeNormal   ctermfg=15  ctermbg=4   cterm=bold  " White on Blue
    highlight StModeInsert   ctermfg=15  ctermbg=2   cterm=bold  " White on Green
    highlight StModeVisual   ctermfg=15  ctermbg=5   cterm=bold  " White on Magenta
    highlight StModeReplace  ctermfg=15  ctermbg=1   cterm=bold  " White on Red
    highlight StModeCmd      ctermfg=15  ctermbg=3   cterm=bold  " White on Yellow
    highlight StFileDetails  ctermfg=15  ctermbg=238 cterm=none  " White on Dark Grey
    highlight StLineCol      ctermfg=0   ctermbg=7   cterm=none  " Black on Light Grey
endfunction
call SetStatuslineColors()

" Automatically re-apply colors if the user switches color schemes later
autocmd ColorScheme * call SetStatuslineColors()

" Returns the current mode name and dynamically switches the highlight group
function! UpdateMode()
    let l:mode = mode()
    if l:mode==#'n'  | execute 'hi! link StCurrentMode StModeNormal'  | return '  NORMAL '  | endif
    if l:mode==#'i'  | execute 'hi! link StCurrentMode StModeInsert'  | return '  INSERT '  | endif
    if l:mode==#'R'  | execute 'hi! link StCurrentMode StModeReplace' | return '  REPLACE ' | endif
    if l:mode==#'v'  | execute 'hi! link StCurrentMode StModeVisual'  | return '  VISUAL '  | endif
    if l:mode==#'V'  | execute 'hi! link StCurrentMode StModeVisual'  | return '  V-LINE '  | endif
    if l:mode==#"\<C-v>" | execute 'hi! link StCurrentMode StModeVisual' | return '  V-BLOCK ' | endif
    if l:mode==#'c'  | execute 'hi! link StCurrentMode StModeCmd'     | return '  COMMAND ' | endif
    return ' ' . l:mode . ' '
endfunction

" Assemble the statusline components
set statusline=
set statusline+=%#StCurrentMode#%{UpdateMode()}   " Dynamic Mode indicator block
set statusline+=%#StFileDetails#\ [%n]\           " Buffer number (e.g.)
set statusline+=%<%f\                             " Path to file (truncated if too long)
set statusline+=%m%r%w\                           " Flags: [+] Modified, [RO] Read-only, [PRV] Preview
set statusline+=%=                                " Push remaining elements to the right side
set statusline+=%Y\                               " File type (e.g. PYTHON, VIM, etc.)
set statusline+=[%{&ff}]\                         " File format (unix, dos, mac)
set statusline+=[%{&fenc!=''?&fenc:&enc}]\        " File encoding (utf-8, latin1, etc.)
set statusline+=%#StLineCol#\ %p%%\               " Percentage of way through file
set statusline+=\ \ %l/%L\ :%c\

" =============================================================
" CUSTOM KEY MAPS
" =============================================================

" Move line up/down using ALT+J/K
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Enable native commenting shortcuts
nmap gcc g_c
vmap gc  g_c

" Clear search highlights easily by hitting spacebar
nnoremap <Space> :noh<CR>

" Make "U" redo
nnoremap U <C-r>

" Reselect after shifting indentation
vnoremap < <gv
vnoremap > >gv
