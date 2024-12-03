"set tabstop=4
"set shiftwidth=4
"set expandtab

set clipboard=unnamed   " copy to system clipboard
set relativenumber
set fileformat=unix

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

if exists('g:vscode')
    " VSCode extension
endif
if exists('is_vsvim')
    " VSStudio extension
    nnoremap gi :vsc Edit.GoToImplementation
    nnoremap gcc :vsc Edit.ToggleLineComment
    nnoremap gr :vsc Edit.FindAllReferences
    nnoremap gp :vsc Edit.PeekDefinition
    vnoremap gcc :vsc Edit.ToggleLineComment

    nnoremap <C-T> :vsc View.NavigateBackward

    nnoremap <Leader>r :vsc Refactor.Rename
    nnoremap <Leader>e :vsc View.NextError
    nnoremap <Leader>E :vsc View.PreviousError
end

