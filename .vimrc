" [Performance] Avoid autocmd piling. See https://gist.github.com/romainl/6e4c15dfc4885cb4bd64688a71aa7063.
augroup once_per_source
  autocmd!
augroup END

" [vim-plug] Auto install vim-plug. See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation.
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '
    \.'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd once_per_source VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" [vim-plug] Auto install missing plugins. See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins.
autocmd once_per_source VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
  \| endif

" [vim-plug] Register plugins. This auto automatically executes `filetype
" plugin indent on` and `syntax enable`. These can be reverted after `plug#end`
" call.  See https://github.com/junegunn/vim-plug#usage.
call plug#begin('~/.vim/plugged')
  "v A universal set of sensible vim defaults. See https://github.com/tpope/vim-sensible.
  Plug 'tpope/vim-sensible'
  "v ALE == Asynchronous Lint Engine. See https://github.com/dense-analysis/ale.
  Plug 'dense-analysis/ale'
  "v gruvbox color scheme. See https://github.com/morhetz/gruvbox.
  Plug 'morhetz/gruvbox'
  "v purify color scheme. See https://github.com/kyoz/purify/tree/master/vim.
  Plug 'kyoz/purify', { 'rtp':'vim' }
  "v Prepopulate JSDoc comments based on function signatures.
  Plug 'heavenshell/vim-jsdoc', { 
    \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
    \ 'do': 'make install'
  \}
  "v JS syntax highlight. Appears to provide better ES6 support than pangloss/vim-javascript.
  Plug 'jelera/vim-javascript-syntax'
  "v
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" [colorscheme]
set background=dark
"v Fix colors being off. See https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support and https://github.com/tmux/tmux/issues/1246.
if exists("+termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" [colorscheme -> gruvbox] Configurations. See https://github.com/morhetz/gruvbox/wiki/Configuration.
" The below is diable since for now I want to use the purify theme.
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark='hard'
"v  Enable the color scheme. See https://github.com/morhetz/gruvbox/wiki/Installation.
"autocmd once_per_source VimEnter * ++nested colorscheme gruvbox

" [colorscheme -> purify]
colorscheme purify

" [Indentation]
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" [Interface]
set number nowrap showcmd

" [Interface -> Margin]
autocmd once_per_source VimEnter * highlight ColorColumn cterm=reverse
  "^ must be after guvbox color scheme is set
set textwidth=79 colorcolumn=+1

" [Interface -> StatusLine]
highlight StatusLine cterm=reverse

" [Search]
set hlsearch ignorecase smartcase

" [ale] Apply the StandardJS style only
" The below is disabled unless at some point I'd like to apply it globally.
"let g:ale_linters = {
"\   'javascript': ['standard'],
"\}
"let g:ale_fixers = {'javascript': ['standard']}
