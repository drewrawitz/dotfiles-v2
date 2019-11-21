"--------------- Plugins --------------"
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sensible'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'jreybert/vimagit'
Plug 'rhysd/git-messenger.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'posva/vim-vue'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'w0rp/ale'
"Plug 'prettier/vim-prettier', {
" \ 'do': 'yarn install',
" \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
"

call plug#end()
"--------------- Config --------------"
let mapleader = "\<Space>"
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
let $MYVIMRC = '~/.vimrc'

" Encoding
set encoding=UTF-8

" enable mouse mode use in all modes
set mouse=a

" highlight matching brackets/showbraces.
set showmatch

" Hide buffer instead of unloading it.
" This fixes nagging 'No write since last change' when switching buffers
set hidden

" Configure persistent undo
" Vim will save undo in file stored in .vim/undodir
set undodir=~/.vim/undodir
set undofile

" makes 'y' and 'p' copy and paste to the global buffer that is used by other
" apps
set clipboard+=unnamed

" Add simple highlight removal
nmap <F7> :set hlsearch!<CR>

" Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Get rid of ugly split borders.
set fillchars+=vert:\|

" Leave insert mode with 'jj'
inoremap jj <ESC>

" Disable error bell sound
set noerrorbells visualbell t_vb=

" Do not pollute the working directory with swap and other files.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Saving a file
nnoremap <Leader>w :w<CR>
command! W  write

" When pasting, go to the end of the pasted content
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"--------------- Movement --------------"
" leave your visual world behind.
nnoremap <up> :echoe "Use k"<CR>
nnoremap <down> :echoe "Use j"<CR>
nnoremap <left> :echoe "Use h"<CR>
nnoremap <right> :echoe "Use l"<CR>

" force myself to leave insert mode for movement.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" no more arrows
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

"--------------- Plugin: Coc --------------"
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)<Paste>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"--------------- Plugin: Goyo  --------------"
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

"--------------- Plugin: ALE --------------"
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'vue': ['prettier', 'eslint'],
\   'scss': ['prettier', 'stylelint'],
\   'css': ['prettier', 'stylelint'],
\}
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"--------------- Plugin: NerdTree --------------"
map <leader>n :NERDTreeToggle<cr>

"--------------- Plugin: NerdCommenter --------------"
map gcc <plug>NERDCommenterComment

"--------------- Plugin: Ctrl-P --------------"
nmap <C-e> :CtrlPMRUFiles<cr>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|deps|_build|node_modules|bower_components|vendor)$',
    \ 'file': '\v\.(swp)$',
    \ }
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'min:1,max:10,results:10'

"--------------- Visuals --------------"
let base16colorspace=256
set background=dark
colorscheme base16-tomorrow
set t_CO=256

"----------------Multiple Curors --------------"
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-q>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"--------------- Text formatting --------------"
set nowrap              " do not wrap lines.
set shiftwidth=2        " use four characters for tabs.
set tabstop=2           " skullcracking.
set expandtab           " expand tabs to spaces.
set relativenumber      " relative line numbers

"--------------- Split Management --------------"
set splitbelow          " when opening a vertical split, open it below
set splitright          " when opening a horizontal split, open it to the right

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" fzf.vim mappings
nnoremap <C-p> :Files<CR>
nnoremap T :Tags<CR>
nnoremap t :BTags<CR>
nnoremap s :Ag<CR>

" Faster buffer switching
nnoremap <leader>b :Buffers<CR>
map <C-m> :bnext<CR>
map <C-n> :bprev<CR>

nmap <Leader>h <Plug>(git-messenger)
nnoremap <leader>/ :History/<CR>
nnoremap <leader>: :History:<CR>
nnoremap <leader>gc :Commits<CR>
nnoremap <leader>gbc :BCommits<CR>
nnoremap <leader>gs :GFiles?<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

