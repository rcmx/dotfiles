
set nocompatible    	" Necesary  for lots of cool vim things
set clipboard=unnamed   " copy to system clipboard

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set hlsearch

let mapleader = " "

inoremap jj <Esc>

map gd :vsc ReSharper.ReSharper_GotoDeclaration<CR>
map gi :vsc Edit.GoToImplementation<CR>
map ]] :vsc Edit.NextMethod<CR>
map [[ :vsc Edit.PreviousMethod<CR>

