
" Set leader key to space
let mapleader = ' '
let maplocalleader = ' '

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tm :tabmove 
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprev<CR>

if &term =~ 'xterm\\|rxvt\\|alacritty\\|kitty'
    let &t_SI = "\e[6 q"  " Use a vertical bar cursor in insert mode
    let &t_EI = "\e[2 q"  " Use a block cursor in normal mode
endif

if exists('$WEZTERM')
    let &t_SI = "▎"  " Use a blinking vertical bar cursor in insert mode
endif

set undodir=~/.vim/undodir
set undofile

" Set number line and relative number
set number
set relativenumber

colorscheme sorbet

" Set tabstop, shiftwidth, expandtab
set tabstop=4
set shiftwidth=4
set expandtab

" Enable cursorline
set cursorline

" Nerd font available flag
let g:have_nerd_font = 1

" Vim Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0

" Enable mouse mode
set mouse=a

" Don't show mode in status line
set noshowmode

" Sync clipboard between OS and Vim
set clipboard=unnamedplus

" Enable break indent
set breakindent

" Save undo history
set undofile

" Case-insensitive searching unless \C or capital in search
set ignorecase
set smartcase

" Keep signcolumn on by default
set signcolumn=yes

" Decrease update time
set updatetime=150

" Decrease mapped sequence wait time
set timeoutlen=250

" Configure how new splits should be opened
set splitright
set splitbelow

" Hide certain whitespace
set nolist


" Show which line your cursor is on
set cursorline

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=5

" Highlight search matches
set hlsearch


" Line break at word boundaries
set linebreak

" Conceal level
set conceallevel=1

set equalalways
set splitbelow
set splitright

set history=1000

nnoremap H ^
nnoremap L g_

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=400}
augroup end


" Clear search highlight with Escape
nnoremap <Esc> :nohlsearch<CR>

set statusline=%f                        " File name
set statusline+=%y                       " File type
set statusline+=%m                       " Modified flag
set statusline+=%r                       " Readonly flag
set statusline+=%{&fileencoding?&fileencoding:&encoding}  " File encoding
set statusline+=%{&fileformat}           " File format (unix, dos, mac)
set statusline+=%=                       " Right-align the rest
set statusline+=%c,%l/%L                 " Column, line number / total lines
set statusline+=\ [%p%%]                 " File position percentage
set statusline+=%{strftime('%H:%M')}     " Current time
set laststatus=2                         " Always display the status line

