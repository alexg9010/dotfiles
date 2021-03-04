"""""""""" GENERAL """""""""" 

" set light background by default
set background=light

" enable filetype plugin
filetype plugin indent on

" disable automatic comment on next line
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" close preview window after autocomplete
autocmd CompleteDone * pclose

" change the way vim replaces text
set wildmode=longest,list:longest

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"set windows split defaults
set splitright
set splitbelow

" delete key fix
nmap <Ctrl-V><Del> x
imap <Ctrl-V><Del> <Ctrl-V><Esc>lxi
set backspace=indent,eol,start
nmap <Ctrl-V><backspace> x
imap <Ctrl-V><backspace> <Ctrl-V><Esc>lxi

" syntax highlighting
syntax on

" show whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Maintain undo history between sessions
" Use persistent history.
if !isdirectory("/home/agosdsc/.vim-undo-dir")
    call mkdir("/home/agosdsc/.vim-undo-dir", "", 0700)

endif
set undodir=~/.vim-undo-dir
set undofile

" show line at 81
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" modify the file explorer layout
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"      autocmd!
"        autocmd VimEnter * :Vexplore
"    augroup END

" set clipboard to system clipboard
set clipboard=unnamed

" set .scm files to lisp filetype
augroup filetypedetect
    au BufRead,BufNewFile *.scm setfiletype lisp
    " associate *.foo with php filetype
augroup END

"""""""""" PLUGINS """""""""" 

" ADD PACKAGE 'before VIM8' style
" add vim-airline
" from https://github.com/vim-airline/vim-airline
set runtimepath^=~/.vim/pack/dist/start/vim-airline
set runtimepath^=~/.vim/pack/dist/opt/vim-airline-themes
let g:airline#extensions#tabline#enabled = 1

" add vimwiki
set runtimepath^=~/.vim/pack/dist/start/vimwiki/
let mapleader = ","
" define additional wiki for projects
let g:vimwiki_list = [
                        \{'path': '~/wiki/vimwiki'},
                        \{'path': '~/wiki/vimwiki/projects'}
                \]
" Find Incomplete Tasks
function! VimwikiFindIncompleteTasks()
	lvimgrep /\(-\|*\|#\) \[ \]/j %:p
	lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /\(-\|*\|#\) \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>

" add calendar.vim for showing calendar plugin
set runtimepath^=~/.vim/pack/dist/start/vim-calendar
" define command to open calendar
nmap <silent> <Leader>wc :Calendar<CR>
nmap <silent> <Leader>wc :Calendar<CR>


" add commentary for toggling comments
set runtimepath^=~/.vim/pack/dist/start/commentary

" add tabular for aligning text
" https://github.com/godlygeek/tabular
set runtimepath^=~/.vim/pack/dist/start/tabular/
" add command to revert alignment of text
" by removing spaces
command -range=% -nargs=+ Untab :<line1>,<line2>s/\s\+<args>\s\+/<args>/g


" add fugitive for optimized git
set runtimepath^=~/.vim/pack/dist/start/vim-fugitive/
set statusline=%{FugitiveStatusline()}
" modify statusline
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#branch#enabled = 1

" add obsession.vim for continous session saving
set runtimepath^=~/.vim/pack/dist/start/vim-obsession

" add ale for syntax check
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_virtualenv_dir_names = []

" add vim surround for simple surrounding
" https://github.com/tpope/vim-surround
" It's easiest to explain with examples. Press cs"' inside
"
" "Hello world!"
" to change it to
"
" 'Hello world!''"
set runtimepath^=~/.vim/packdist/start/vim-surround


" add nvim-r for r-console 
set runtimepath^=~/.vim/pack/dist/start/Nvim-R
" Change Leader and LocalLeader keys:
let maplocalleader = ';'
let mapleader = ','
" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
   inoremap <C-Space> <C-x><C-o>
else
   inoremap <Nul> <C-x><C-o>
endif
" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
" disable replacement of _ with <-
let R_assign = 0
" " add tmux support
" let R_source = '~/.vim/pack/dist/start/Nvim-R/R//tmux_split.vim'
" let R_in_buffer = 0                                                       
" let g:R_term_cmd = 'tmux split-window -c "#{pane_current_path}"'



" add vim-tmux-navigator to move via <CTRL>-h,j,k,l from/to tmux
" https://www.bugsnag.com/blog/tmux-and-vim
set runtimepath^=~/.vim/pack/dist/start/vim-tmux-navigator

" add fzf.vim for fuzzy file and code search
" installed with guix
set runtimepath^=~/.fzf
set runtimepath^=~/.vim/pack/dist/start/fzf.vim
" Make :Ag not match file names, only the file content
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <C-g> :Rg<Cr>
nnoremap <C-f> :Files<Cr>

" add coc autocomple
set runtimepath^=~/.vim/pack/coc/start/coc.nvim-release
let g:coc_disable_startup_warning = 1
" add python support 
" :CocInstall coc-python
" add markdown support 
" :CocInstall coc-markdownlint
" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ADD optional PACKAGE 'after VIM8'
" :packadd! undotree
" :packadd! vim-airline-themes 




