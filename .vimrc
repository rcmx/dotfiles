"set tabstop=4
"set shiftwidth=4
"set expandtab

set clipboard=unnamed   " copy to system clipboard
set relativenumber

let mapleader = " "

"""""""""""""""""
" file specific
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"""""""""""""""""
" mapping
noremap <C-u> <C-u>zz
noremap <C-d> <C-d>zz

nnoremap <Leader>b :ls<CR>:b<Space>

inoremap jj <Esc>

if exists('has_vsvim')
    nnoremap gi :vsc Edit.GoToImplementation<CR>
    nnoremap gcc :vsc Edit.ToggleLineComment<CR>
    nnoremap gr :vsc Edit.FindAllReferences<CR>
    nnoremap gp :vsc Edit.PeekDefinition<CR>
    vnoremap gcc :vsc Edit.ToggleLineComment<CR>

    nnoremap <Leader>r :vsc Refactor.Rename<CR>
    nnoremap <Leader>e :vsc View.NextError<CR>
    nnoremap <Leader>E :vsc View.PreviousError<CR>
end

