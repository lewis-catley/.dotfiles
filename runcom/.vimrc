" Install vim plug if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')

" plugin section
" ColorScheme for VIm
Plug 'morhetz/gruvbox'

" Intelisense linting and code sense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Markdown Previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Golang
Plug 'fatih/vim-go'

" end vim-plug
call plug#end()

" Colorscheme config
set background=dark
" solarized options
let g:solarized_termtrans = 1
colorscheme solarized

" Absolute line numbering with relative postion
set nu

" Remove vim bell
autocmd GUIEnter * set vb t_vb=
syntax enable

" Fancy colours
let g:vim_jsx_pretty_colorful_config = 1

" Coc config and setup
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Organise imports in typescript files
nmap <leader>i :CocCommand tsserver.organizeImports<cr>

" Show available buffers in vim
nnoremap <Leader>b :buffers<CR>:buffer<Space>

" Show certain chars as symbols
set listchars=nbsp:_,tab:>-,trail:~
set list
