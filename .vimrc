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

" [plugin -> ale] configure for neoclide/coc.nvim compatibility. See https://github.com/dense-analysis/ale#5iii-how-can-i-use-ale-and-cocnvim-together
let g:ale_disable_lsp = 1

" [plugin -> vim-polyglot]
" Disable javascript pack since I prefer [plugin -> vim-javascript-syntax]
let g:polyglot_disabled = ['javascript']

" [vim-plug] Register plugins. This auto automatically executes `filetype
" plugin indent on` and `syntax enable`. These can be reverted after `plug#end`
" call.  See https://github.com/junegunn/vim-plug#usage.
call plug#begin('~/.vim/plugged')
  "v A universal set of sensible vim defaults.
  Plug 'tpope/vim-sensible'
  "v ALE == Asynchronous Lint Engine.
  Plug 'dense-analysis/ale'
  "v gruvbox color scheme.
  Plug 'morhetz/gruvbox'
  "v purify color scheme.
  Plug 'kyoz/purify', { 'rtp':'vim' }
  "v onedark color scheme.
  Plug 'joshdick/onedark.vim'
  "v Prepopulate JSDoc comments based on function signatures.
  Plug 'heavenshell/vim-jsdoc', { 
    \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
    \ 'do': 'make install'
  \}
  "v Collection of language packs (for syntax, linting etc.).
  Plug 'sheerun/vim-polyglot'
  "v JS syntax highlight. Appears to provide better ES6 support than pangloss/vim-javascript.
  Plug 'jelera/vim-javascript-syntax'
  "v Conquer of Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "v Make scrolling smooth.
  Plug 'psliwka/vim-smoothie'
call plug#end()

" [colorscheme]
set background=dark
"v Fix colors being off. See https://github.com/morhetz/gruvbox/wiki/Terminal-specific#0-recommended-neovimvim-true-color-support and https://github.com/tmux/tmux/issues/1246.
if exists("+termguicolors")
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"v Set here a color scheme which does not require special settings. (An exception would be gruvbox.)
colorscheme purify

" [colorscheme -> gruvbox] Configurations. See https://github.com/morhetz/gruvbox/wiki/Configuration.
"v Diable since for now I want to use the purify theme.
"let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark='hard'
"v Enable the color scheme. See https://github.com/morhetz/gruvbox/wiki/Installation.
"autocmd once_per_source VimEnter * ++nested colorscheme gruvbox

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

" [plugin -> ale] Customize linters and fixers.
let g:ale_linters = {
"\   'javascript': ['standard'],
\   'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
"\ 'javascript': ['standard'],
\   'python': ['yapf'],
\}
