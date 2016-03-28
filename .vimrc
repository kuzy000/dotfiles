set t_Co=256
syntax on

set tabstop=4
set shiftwidth=4
set softtabstop=4

set listchars=tab:»\ 
set list
set laststatus=2
set nu
"set wrap!
set fillchars+=vert:│
set backspace=indent,eol,start

let NERDTreeShowBookmarks=1
let g:session_autosave = 'no'
let g:session_autoload = 'no'
let g:clang_use_library = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:airline_exclude_preview=1

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'


au Bufenter *.hs compiler ghc

set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

map <C-h> :tabp<cr> 
map <C-l> :tabn<cr>
map <F4> :NERDTreeToggle<cr>
nmap <C-x><C-j> :FSHere<cr>

command! W w
command! Q q

command! Tree NERDTreeTabsToggle

set wildmenu
set wildmode=list:longest,full
set mouse=a

set guioptions= 
set guifont=Ubuntu\ Mono\ 11

set foldmethod=syntax
set foldlevel=99

set cino+=g0
 
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
	let cmd = 'norm!z' . a:dir
	let view = winsaveview()
	let [l0, l, open] = [0, view.lnum, 1]
	while l != l0 && open
		exe cmd
		let [l0, l] = [l, line('.')]
		let open = foldclosed(l) < 0
	endwhile
	if open
		call winrestview(view)
	endif
endfunction

autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab

autocmd Filetype lisp setlocal ts=2 sts=2 sw=2 expandtab

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'

" --- 

"Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
"Plugin 'Rip-Rip/clang_complete'
Plugin 'scrooloose/nerdtree'
Plugin 'lukerandall/haskellmode-vim'
"Plugin 'Shougo/neocomplcache.vim'
"Plugin 'kien/ctrlp.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-scripts/Limp'
Plugin 'mgutz/vim-colors'
Plugin 'myusuf3/numbers.vim'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'morhetz/gruvbox'
Plugin 'nelstrom/vim-mac-classic-theme'
Plugin 'sickill/vim-monokai'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'baskerville/bubblegum'
Plugin 'altercation/vim-colors-solarized'
Plugin 'skammer/vim-css-color'
Plugin 'jdonaldson/vaxe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'lambdatoast/elm.vim'
Plugin 'tpope/vim-rails'
Plugin 'blueshirts/darcula'
Plugin 'sheerun/vim-polyglot'
"Plugin 'dag/vim2hs' "laggs

" ---

filetype plugin indent on

colorscheme darcula

