" =====================
" ||  ==> VIMRC <==  ||
" =====================

" =============================================================
" GENERAL SETTINGS
" =============================================================

syntax on
set nocompatible
set number
set relativenumber
set cursorline
set cursorlineopt=number
set numberwidth=2
set history=500
set encoding=utf-8
set mouse=a
set autoread
set nowrap
set nobackup
set nowb
set noswapfile
au FocusGained,BufEnter * silent! checktime
au BufRead,BufNewFile /tmp/zsh* set filetype=zsh
filetype plugin on
filetype indent on
command! Q qa
command! W w
packadd! comment
packadd! hlyank
  let g:hlyank_hlgroup = 'Yank'
set viminfo+=n~/.local/state/vim/info
if $TERM == 'linux' | set t_Co=16 | endif
set wildmenu
set lazyredraw
set ruler
set hidden
set noerrorbells
set novisualbell
set t_vb=
set tm=1000
set list
set listchars=tab:▸\ ,trail:-,nbsp:␣
set ww=b,s,<,>,[,] "sets what characters can wrap text from first/last char of line to last/first of the previous/next.
set foldcolumn=1
set confirm
set noequalalways
set switchbuf=useopen,usetab,newtab
set helpheight=30

" === Set cursor shape based on mode ===
let &t_SI .= "\<Esc>[6 q" " Insert mode: steady vertical bar
let &t_SR .= "\<Esc>[4 q" " Replace mode: steady underline
let &t_EI .= "\<Esc>[2 q" " Normal mode: steady block
augroup CmdlineCursorFix
  autocmd!
  autocmd CmdlineEnter * call echoraw(&t_SI)
  autocmd CmdlineLeave * call echoraw(&t_EI)
  autocmd CmdWinEnter * call echoraw(&t_EI)
augroup END

" === Tabs & Indentation ===
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" === Search ===
set hlsearch
set incsearch
set ignorecase
set smartcase

" =============================================================
" FILE EXPLORER
" =============================================================

" === Setting Newtrw Options ===
let g:netrw_banner = 0          " Hide top banner
let g:netrw_liststyle = 3       " Use tree view
let g:netrw_browse_split = 4    " Open files in previous window
let g:netrw_winsize = 15        " Set width to 15%

" === Custom Styling ===
augroup netrw-styling
  autocmd!
  autocmd FileType netrw setlocal statusline=\ "intentional trailing space
  autocmd FileType netrw if &encoding == 'utf-8' | call s:NetrwTreeBarStyle() | endif
  autocmd VimEnter,ColorScheme * call s:PaneSplitStyle()
augroup END

function! s:NetrwTreeBarStyle() abort
  setlocal conceallevel=2
  setlocal concealcursor=nvic
  syntax match netrwTreeBar /|/ containedin=ALL conceal cchar=│
  hi! Conceal cterm=NONE gui=NONE ctermbg=NONE guibg=NONE ctermfg=8 guifg=NONE
endfunction

function! s:PaneSplitStyle() abort
  if &encoding == 'utf-8'
    set fillchars=vert:│,fold:▼,foldopen:▼,foldclose:►,eob:\ ,lastline:@
    hi! VertSplit cterm=NONE gui=NONE ctermbg=NONE guibg=NONE ctermfg=15 guifg=white
  else
    set fillchars=vert:\ ,fold:▼,foldopen:▼,foldclose:►,eob:\ ,lastline:@
    hi! VertSplit cterm=NONE gui=NONE ctermbg=15 guibg=white ctermfg=15 guifg=white
  endif
endfunction

call s:PaneSplitStyle()

" =============================================================
" STATUS-LINE
" =============================================================

set laststatus=2
set noshowmode

function! StatuslineColors()
  hi StModeNormal   ctermfg=15  ctermbg=4   cterm=bold  " White on Blue
  hi StModeInsert   ctermfg=15  ctermbg=2   cterm=bold  " White on Green
  hi StModeVisual   ctermfg=15  ctermbg=5   cterm=bold  " White on Magenta
  hi StModeReplace  ctermfg=15  ctermbg=1   cterm=bold  " White on Red
  hi StModeCmd      ctermfg=15  ctermbg=3   cterm=bold  " White on Yellow
  hi StFileDetails  ctermfg=15  ctermbg=8   cterm=none  " White on Dark Grey
  hi StLineCol      ctermfg=0   ctermbg=7   cterm=none  " Black on Dim White
endfunction

call StatuslineColors()
autocmd ColorScheme * call StatuslineColors()

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

"statusline components
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
set statusline+=\ \ %l/%L\ :%c\ "intentional trailing space

" =============================================================
" FUNCTIONS
" =============================================================

function! SyntaxDebug()
  let l:stack = synstack(line('.'), col('.'))
  if empty(l:stack) | echo "No active syntax groups." | return | endif

  for l:id in l:stack
    let l:name = synIDattr(l:id, 'name')
    execute 'hi ' . l:name
    execute 'syntax list ' . l:name
    echoh String | echo "========================================" | echoh None
  endfor
endfunction

" =============================================================
" CUSTOM KEY MAPS
" =============================================================

" === General ===
nnoremap <Space> :noh<CR>
nnoremap Y y$
nnoremap U <C-r>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
nnoremap <M-v> <C-v>
noremap <C-f> :Lexplore!<CR>
"Open cmdline buffer
nnoremap <C-q> q:
autocmd CmdwinEnter * nnoremap <buffer> <C-q> :q<CR>
"switch window focus
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"move line up/down using [number]+alt+j/k
nnoremap <expr> <M-j> 'mz:<C-u>execute "m+".'.v:count1.'<CR>`z'
nnoremap <expr> <M-k> 'mz:<C-u>execute "m-".'.(v:count1+1).'<CR>`z'
vnoremap <expr> <M-j> ":m'>+".v:count1."<CR>`<my`>mzgv`yo`z"
vnoremap <expr> <M-k> ":m'<-".(v:count1+1)."<CR>`>my`<mzgv`yo`z"

" === Maintain Selections ===
"indentation shifting
vnoremap < <gv
vnoremap > >gv
"inc/decrement integer
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

" === Leader Binds ===
nnoremap ,z :call SyntaxDebug()<CR>

" =============================================================
" SYNTAX HIGHLIGHTING CONFIGURATION
" =============================================================

set notermguicolors
colorscheme default

" === Defaults ===
hi! LineNr          ctermfg=4
hi! CursorLineNr    ctermfg=7    cterm=NONE
hi! Folded          ctermfg=3    ctermbg=NONE
hi! FoldColumn      ctermfg=3    ctermbg=NONE
hi! Comment         ctermfg=4    term=bold
hi! Normal          ctermfg=7    ctermbg=NONE
hi! Yank            ctermfg=7    ctermbg=3    term=reverse  gui=reverse

" === ANSI-16 ===
if &t_Co >= 16
  hi! LineNr          ctermfg=8
  hi! Comment         ctermfg=8    cterm=italic    term=bold
  hi! Underlined      ctermfg=12   cterm=underline
  hi! Search          ctermfg=15   ctermbg=11      term=reverse
  hi! Ignore          ctermfg=8
  hi! Error           ctermfg=15   ctermbg=9       term=reverse
  hi! Todo            ctermfg=0    ctermbg=11      term=standout
  hi! NonText         ctermfg=8
  hi! Folded          ctermfg=11
  hi! FoldColumn      ctermfg=11
  hi! SpecialKey      ctermfg=8
  hi! Yank            ctermfg=0    ctermbg=11
  hi! Constant        ctermfg=13
    hi! String          ctermfg=10
    hi! Character       ctermfg=9
    hi! Number          ctermfg=13
    hi! Boolean         ctermfg=13
    hi! Float           ctermfg=13
  hi! Identifier      ctermfg=9    cterm=bold
    hi! Function        ctermfg=12
  hi! Statement       ctermfg=9
    hi! Conditional     ctermfg=13
    hi! Repeat          ctermfg=11
    hi! Label           ctermfg=11
    hi! Operator        ctermfg=12
    hi! Keyword         ctermfg=13
    hi! Exception       ctermfg=9
  hi! PreProc         ctermfg=11
    hi! Include         ctermfg=12
    hi! Define          ctermfg=10
    hi! Macro           ctermfg=9
    hi! PreCondit       ctermfg=11
  hi! Type            ctermfg=11
    hi! StorageClass    ctermfg=11
    hi! Structure       ctermfg=13
    hi! Typedef         ctermfg=11
  hi! Special         ctermfg=6
    hi! SpecialChar     ctermfg=5
    hi! Tag             ctermfg=11
    hi! Delimiter       ctermfg=5
    hi! SpecialComment  ctermfg=14
    hi! Debug           ctermfg=9
endif

" === Tru-Term ===
if &t_Co >= 256
  hi! Yank            ctermfg=15        ctermbg=166
  "constant
  hi! Constant        ctermfg=208
    hi! Number          ctermfg=208
    hi! Boolean         ctermfg=208
    hi! Float           ctermfg=208
  "special
    hi! SpecialChar     ctermfg=166
    hi! Delimiter       ctermfg=166
endif

" ==================
" -> SHELL-SYNTAX <-
" ==================

if &t_Co >= 16
  "constant
  hi! shEcho          ctermfg=9
  "identifier
  hi! shVariable      ctermfg=7
  "statement
  hi! shStatement     ctermfg=12
    hi! shLoop          ctermfg=11
    hi! bashStatement   ctermfg=13
  hi! shQuote         ctermfg=10
  hi! shCurlyIn       ctermfg=12
  hi! shTestOpr       ctermfg=12
  hi! shOperator      ctermfg=5
    hi! shDerefOp       ctermfg=14
  "preproc
  hi! shArithRegion   ctermfg=14
  "special
  hi! shCommandSub    ctermfg=9
  hi! shArithmetic    ctermfg=12
  hi! shVarAssign     ctermfg=12
endif

if &t_Co >= 256
  "statement
  hi! shOperator      ctermfg=166
endif

" =============================================================
" CLIPBOARD INTERGRATION
" =============================================================

set clipboard=unnamedplus

" === Wayland Clipboard ===
if !exists('g:loaded_wayland_clipboard') && executable('wl-copy')
  let g:loaded_wayland_clipboard = 1 | let g:WLC_plus_to_w = exists('g:wayland_clipboard_plus_to_w') ? g:wayland_clipboard_plus_to_w : !has('clipboard') || empty($DISPLAY)
  if exists('g:wayland_clipboard_no_plus_to_w') | let g:WLC_plus_to_w = 0 | endif | if g:WLC_plus_to_w | nnoremap "+ "w | vnoremap "+ "w | endif
  let g:WLC_copy_command = exists('g:wayland_clipboard_copy_command') ? g:wayland_clipboard_copy_command : 'wl-copy' | let g:WLC_copy_args = exists('g:wayland_clipboard_copy_args') ? g:wayland_clipboard_copy_args : []
  function! g:WLC_unnamedplus()
    return &clipboard =~ 'unnamedplus' || (exists('g:wayland_clipboard_unnamedplus') && g:wayland_clipboard_unnamedplus)
  endfunction
  function! g:WLC_WaylandYank()
    if v:event['regname'] == '+' || (v:event['regname'] == 'w' && g:WLC_plus_to_w) || (v:event['regname'] == '' && g:WLC_unnamedplus())
      let job = job_start([g:WLC_copy_command] + g:WLC_copy_args, { "in_io": "pipe", "out_io": "null", "err_io": "null", "stoponexit": "", })
      call ch_sendraw(job, getreg(v:event['regname'])) | call ch_close(job) | let g:WLC_last_job = job | endif
  endfunction
  augroup waylandyank | autocmd! | autocmd TextYankPost * call g:WLC_WaylandYank() | augroup END
  let g:WLC_paste_command = exists('g:wayland_clipboard_paste_command') ? g:wayland_clipboard_paste_command : 'wl-paste --no-newline'
  let g:WLC_paste_args = exists('g:wayland_clipboard_paste_args') ? g:wayland_clipboard_paste_args : [] | let g:WLC_paste_args_str = empty(g:WLC_paste_args) ? '' : ' ' . join(g:WLC_paste_args)
  function! g:WLC_clipboard_to_unnamed()
    silent let @"=substitute(system(g:WLC_paste_command . g:WLC_paste_args_str), "\r", '', 'g')
  endfunction
  function! g:WLC_put(p, fallback)
    if a:fallback | return a:p | endif | call g:WLC_clipboard_to_unnamed()
    return '""' . a:p
  endfunction
  function! g:WLC_ctrl_r(cr)
    call g:WLC_clipboard_to_unnamed()
    return a:cr . '"'
  endfunction
  nnoremap <expr> <silent> "+p g:WLC_put('p', v:false) | nnoremap <expr> <silent> p g:WLC_put('p', !g:WLC_unnamedplus()) | vnoremap <expr> <silent> "+p g:WLC_put('p', v:false)
  nnoremap <expr> <silent> "+P g:WLC_put('P', v:false) | nnoremap <expr> <silent> P g:WLC_put('P', !g:WLC_unnamedplus()) | vnoremap <expr> <silent> "+P g:WLC_put('P', v:false)
  vnoremap <expr> <silent> p g:WLC_put('p', !g:WLC_unnamedplus()) | inoremap <expr> <silent> <C-R><C-R>+ g:WLC_ctrl_r("\<C-R>\<C-R>") | inoremap <expr> <silent> <C-R><C-O>+ g:WLC_ctrl_r("\<C-R>\<C-O>")
  vnoremap <expr> <silent> P g:WLC_put('P', !g:WLC_unnamedplus()) | inoremap <expr> <silent> <C-R><C-P>+ g:WLC_ctrl_r("\<C-R>\<C-P>") | inoremap <expr> <silent> <C-R>+ g:WLC_ctrl_r("\<C-R>")
endif

" === X11 Clipboard ===
if !exists('g:loaded_wayland_clipboard') && !exists('g:loaded_X11_clipboard') && executable('xclip')
  let g:loaded_X11_clipboard = 1 | let g:XCB_plus_to_w = exists('g:X11_clipboard_plus_to_w') ? g:X11_clipboard_plus_to_w : !has('clipboard') || empty($DISPLAY)
  if exists('g:X11_clipboard_no_plus_to_w') | let g:XCB_plus_to_w = 0 | endif | if g:XCB_plus_to_w | nnoremap "+ "w | vnoremap "+ "w | endif
  let g:XCB_copy_command = exists('g:X11_clipboard_copy_command') ? g:X11_clipboard_copy_command : 'xclip' | let g:XCB_copy_args = exists('g:X11_clipboard_copy_args') ? g:X11_clipboard_copy_args : ['-selection', 'clipboard']
  function! g:XCB_unnamedplus()
    return &clipboard =~ 'unnamedplus' || (exists('g:X11_clipboard_unnamedplus') && g:X11_clipboard_unnamedplus)
  endfunction
  function! g:XCB_X11Yank()
    if v:event['regname'] == '+' || (v:event['regname'] == 'w' && g:XCB_plus_to_w) || (v:event['regname'] == '' && g:XCB_unnamedplus())
      let job = job_start([g:XCB_copy_command] + g:XCB_copy_args, { "in_io": "pipe", "out_io": "null", "err_io": "null", "stoponexit": "", })
      call ch_sendraw(job, getreg(v:event['regname'])) | call ch_close(job) | let g:XCB_last_job = job | endif
  endfunction
  augroup X11yank | autocmd! | autocmd TextYankPost * call g:XCB_X11Yank() | augroup END
  let g:XCB_paste_command = exists('g:X11_clipboard_paste_command') ? g:X11_clipboard_paste_command : 'xclip -selection clipboard -o'
  let g:XCB_paste_args = exists('g:X11_clipboard_paste_args') ? g:X11_clipboard_paste_args : [] | let g:XCB_paste_args_str = empty(g:XCB_paste_args) ? '' : ' ' . join(g:XCB_paste_args)
  function! g:XCB_clipboard_to_unnamed()
    silent let @"=substitute(system(g:XCB_paste_command . g:XCB_paste_args_str), "\r", '', 'g')
  endfunction
  function! g:XCB_put(p, fallback)
    if a:fallback | return a:p | endif | call g:XCB_clipboard_to_unnamed()
    return '""' . a:p
  endfunction
  function! g:XCB_ctrl_r(cr)
    call g:XCB_clipboard_to_unnamed()
    return a:cr . '"'
  endfunction
  nnoremap <expr> <silent> "+p g:XCB_put('p', v:false) | nnoremap <expr> <silent> p g:XCB_put('p', !g:XCB_unnamedplus()) | vnoremap <expr> <silent> "+p g:XCB_put('p', v:false)
  nnoremap <expr> <silent> "+P g:XCB_put('P', v:false) | nnoremap <expr> <silent> P g:XCB_put('P', !g:XCB_unnamedplus()) | vnoremap <expr> <silent> "+P g:XCB_put('P', v:false)
  vnoremap <expr> <silent> p g:XCB_put('p', !g:XCB_unnamedplus()) | inoremap <expr> <silent> <C-R><C-R>+ g:XCB_ctrl_r("\<C-R>\<C-R>") | inoremap <expr> <silent> <C-R><C-O>+ g:XCB_ctrl_r("\<C-R>\<C-O>")
  vnoremap <expr> <silent> P g:XCB_put('P', !g:XCB_unnamedplus()) | inoremap <expr> <silent> <C-R><C-P>+ g:XCB_ctrl_r("\<C-R>\<C-P>") | inoremap <expr> <silent> <C-R>+ g:XCB_ctrl_r("\<C-R>")
endif
"yeah this X11 shit is entirely untested and just about the worst thing I've done in my entire life. You gotta understand I've been torturing myself with
"Vim's CLiPboaRd pRoVIDer bullshit all day and at this point I think it might just be a there to fucking tease you I swear to God Almighty. They seriously
"bunddle a file explorer pluggin but not a fucking clipboard plugin? Just Fuckin shoot me. I'm not asking for full X11 and Wayland Libraries getting bundled
"in here! Just a fucking script or two jesus.
