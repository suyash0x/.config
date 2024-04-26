
call plug#begin()

	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'jiangmiao/auto-pairs'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-commentary'
	Plug 'sainnhe/gruvbox-material'

call plug#end()

if has('termguicolors')
   set termguicolors
endif


let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_foreground ='mix'

colorscheme gruvbox-material
set background=dark
syntax on
set relativenumber
set tabstop=4
set shiftwidth=4
set path=$PWD/**
set wildmenu
set wildignore+=**/.git/**
set incsearch
set noswapfile
set tags=tags;
let mapleader=" "
set laststatus=2
set noshowmode
set signcolumn=yes
set updatetime=100

imap jj <Esc>
set showcmd
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>k :LspHover<cr>

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

filetype plugin indent on



function! FormatJsFiles ()
  	let save_cursor = getpos('.')
    	let save_view = winsaveview()
	silent! execute '%!npx prettier --stdin-filepath %'
   	call setpos('.', save_cursor)
    	call winrestview(save_view)
endfunction


function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gs <plug>(lsp-document-symbol-search)
	nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> gi <plug>(lsp-implementation)
	nmap <buffer> gt <plug>(lsp-type-definition)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> [g <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	nmap <buffer> K <plug>(lsp-hover)
	nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
	nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
	autocmd! BufWritePre *js,*jsx,*.ts,*.tsx,*css call execute('LspDocumentFormatSync --server=efm-langserver')
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_settings = {
  \  'efm-langserver': {
  \    'disabled': 0,
  \    'args': ['-c='.expand('~/.config/efm-langserver/config.yaml')],
  \  },
\}

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
			\ 'name': 'file',
			\ 'allowlist': ['*'],
			\ 'priority': 10,
			\ 'completor': function('asyncomplete#sources#file#completor')
			\ }))
