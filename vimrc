"======================================================================
" 基础设置
"======================================================================
" 禁用vi兼容模式
set nocompatible
" 自动缩进
set autoindent
" 打开c/c++语言进行缩进优化
set cindent
" 不自动换
set nowrap
" 打开快捷超时检测并且设置超时为50毫秒
set timeoutlen=1000 ttimeoutlen=0
" 显示光标置
set ruler
set number
set relativenumber
set showmode
set clipboard+=unnamed
set showcmd
let mapleader=" "
" 保持5行在屏幕底部
set scrolloff=5
" 保持10列代码在右边
set sidescroll=20


"======================================================================
" 搜索设置
"======================================================================
" 搜索时忽略大小写
set ignorecase
" 智能搜索大小写判断
set smartcase
" 高亮搜索内容
set hlsearch
" 查找时动态增量显示查找结果
set incsearch

"======================================================================
" 编码设置
"======================================================================
if has('multi_byte')
	" 内部工作编码
	set encoding=utf-8
	" 文件默认编码
	set fileencoding=utf-8
	" 打开文件时自动阐释下面顺序的编码
	set fileencodings=usc-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1
endif

"======================================================================
" 允许vim自带脚本根据文件类型自动设置缩进等
"======================================================================
if has('autocmd')
	filetype plugin indent on
endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif

"======================================================================
" 语法高亮设置
"======================================================================
if has('syntax')
	syntax enable
	syntax on
endif

"======================================================================
" 其他设置
"======================================================================
" 显示匹配的括号
set showmatch

" 显示括号匹配的时间
set matchtime=2

" 显示最后一行
set display=lastline

" 自动保存
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"======================================================================
" 插件设置
"======================================================================
call plug#begin()
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" tabular plugin is used to format tables
	Plug 'godlygeek/tabular'
	" coc.nvim
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" 语法检查
	Plug 'neomake/neomake'
	" 括号匹配
	Plug 'jiangmiao/auto-pairs'
	" 树状目录插件 
	" <Nerdtree>-------------------{
	    Plug 'scrooloose/nerdtree'          " File tree manager
            Plug 'jistr/vim-nerdtree-tabs'      " enhance nerdtree's tabs
            Plug 'ryanoasis/vim-devicons'       " add beautiful icons besides files
            Plug 'Xuyuanp/nerdtree-git-plugin'  " display git status within Nerdtree
            Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " enhance devicons
	    ">> Basic settings
		let g:NERDTreeChDirMode = 2  "Change current folder as root
		autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |cd %:p:h |endif

	    ">> UI settings
		let NERDTreeQuitOnOpen=1   " Close NERDtree when files was opened
		let NERDTreeMinimalUI=1    " Start NERDTree in minimal UI mode (No help lines)
		let NERDTreeDirArrows=1    " Display arrows instead of ascii art in NERDTree
		let NERDTreeChDirMode=2    " Change current working directory based on root directory in NERDTree
		let g:NERDTreeHidden=1     " Don't show hidden files
		let NERDTreeWinSize=30     " Initial NERDTree width
		let NERDTreeAutoDeleteBuffer = 1  " Auto delete buffer deleted with NerdTree
		let NERDTreeShowBookmarks=0   " Show NERDTree bookmarks
		let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '__pycache__']   " Hide temp files in NERDTree
		"let g:NERDTreeShowLineNumbers=1  " Show Line Number
	    " Open Nerdtree when there's no file opened
		autocmd vimenter * if !argc()|NERDTree|endif
	    " Or, auto-open Nerdtree
		"autocmd vimenter * NERDTree
	    " Close NERDTree when there's no other windows
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	    " Customize icons on Nerdtree
		let g:NERDTreeDirArrowExpandable = '▸'
		let g:NERDTreeDirArrowCollapsible = '▾'

	    ">> NERDTREE-GIT
		" Special characters
	    let g:NERDTreeIndicatorMapCustom = { 
		\ "Modified"  : "✹",
		\ "Staged"    : "✚",
		\ "Untracked" : "✭",
		\ "Renamed"   : "➜",
		\ "Unmerged"  : "═",
		\ "Deleted"   : "✖",
		\ "Dirty"     : "✗",
		\ "Clean"     : "✔︎",
		\ 'Ignored'   : '☒',
		\ "Unknown"   : "?"
	    \ }

	    ">> NERDTree-Tabs
		"let g:nerdtree_tabs_open_on_console_startup=0 "Auto-open Nerdtree-tabs on VIM enter
	    ">> Nerdtree-devicons
		set guifont=DroidSansMono_Nerd_Font:h11
	    ">> Nerdtree-syntax-highlighting
		let g:NERDTreeDisableFileExtensionHighlight = 1
		let g:NERDTreeDisableExactMatchHighlight = 1
		let g:NERDTreeDisablePatternMatchHighlight = 1
		let g:NERDTreeFileExtensionHighlightFullName = 1
		let g:NERDTreeExactMatchHighlightFullName = 1
		let g:NERDTreePatternMatchHighlightFullName = 1
		let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
		let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
		let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
	" }

	" Easymotion {
		Plug 'easymotion/vim-easymotion'
	"}
	call plug#end()

"
"======================================================================
" 按键修改
"======================================================================
inoremap jj <Esc>
inoremap jk <Esc>
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

vnoremap v <Esc>
" 目录树
nnoremap <leader>w :NERDTreeToggle<cr>

" 注释
nnoremap <c-/> I//

"======================================================================
" coc.NVIM setting
"======================================================================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
" 听说有BUG 但是应该没有
"set nobackup
"set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> qj :call <SID>show_documentation()<CR>

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
nmap <leader>rn <Plug>(coc-rename)

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

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
