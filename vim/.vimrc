"语法高亮
syntax on

"设置支持256色
set t_Co=256

"vim主题
set background=dark
"set background=light
colorscheme solarized8

" 光标显示方格
highlight CursorLine cterm=none ctermbg=238
highlight CursorColumn cterm=none ctermbg=238
set cursorcolumn
set cursorline

"显示行号
set number

"自动缩进与C语言风格缩进
set autoindent
set cindent

"缩进宽度
set tabstop=8
set softtabstop=8
set shiftwidth=8
"建议开启expandtab选项，会自动将tab扩展很空格，代码缩进会更美观set expandtab

"switch case 对齐风格
set cino=g0,:0

"使用鼠标
set mouse=a

"生成tags文件 ctags -R --c++-kinds=+px --fields=+iaS --extra=+q
"scope setting

if has("cscope")
	set csprg=/usr/bin/cscope              "指定用来执行 cscope 的命令
	set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
	set cst                                "使用|:cstag|(:cs find g)，而不是缺省的:tag
	set nocsverb                           "不显示添加数据库是否成功
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out               "添加cscope数据库
	endif
	set csverb                             "显示添加成功与否
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"设置 taglist
let Tlist_Show_One_File=1   "只显示当前文件的tags
let Tlist_WinWidth=30        "设置taglist宽度
let Tlist_Exit_OnlyWindow=1  "tagList窗口是最后一个窗口，则退出Vim
let Tlist_Use_Left_Window=1 "在Vim窗口左侧显示taglist窗口
"使用当前目录下tags和子目录下tags
set tags=tags;
set autochdir

"搜索高亮
set hls

" Trinity 工具管理显示窗口
" Open and close all the three plugins on the same time 
nmap <F8>  :TrinityToggleAll<CR> 
" Open and close the Source Explorer separately 
nmap <F9>  :TrinityToggleSourceExplorer<CR> 
" Open and close the Taglist separately 
nmap <F10> :TrinityToggleTagList<CR> 
" Open and close the NERD Tree separately 
nmap <F11> :TrinityToggleNERDTree<CR> 
"nmap <C-n> :NERDTreeToggle<CR>

" NERDTree setting defaults to work around http://github.com/scrooloose/nerdtree/issues/489
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = "RO"
let g:NERDTreeNodeDelimiter = "\u00a0"

" Plug 安装
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'yggdroot/indentline'

" Trinity 管理下面的插件
Plug 'wesleyche/Trinity'
Plug 'wesleyche/SrcExpl'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/taglist.vim'

" 搜索文件和字符串 Files xxx 和 Ag xxx
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" 代码补全
Plug 'ycm-core/YouCompleteMe'

" farmergreg/vim-lastplace
Plug 'farmergreg/vim-lastplace'
" python-mode python IDE 环境
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" 添加cscope数据库, add nmap
Plug 'diabloneo/cscope_maps.vim'
" linux 风格代码提示
Plug 'vivien/vim-linux-coding-style'

" Initialize plugin system
call plug#end()

" lastplace 插件设置
let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
let g:lastplace_ignore_buftype = "quickfix,nofile,help"
" let g:lastplace_open_folds = 0

" YouCompleteMe 插件设置
" 禁用syntastic来对python检查
let g:syntastic_ignore_files=[".*\.py$"]
" 使用ctags生成的tags文件
let g:ycm_collect_identifiers_from_tag_files = 1
" 开启语义补全
" 修改对C语言的补全快捷键，默认是CTRL+space，修改为ALT+;未测出效果
"let g:ycm_key_invoke_completion = '<M-;>'
" 设置转到定义处的快捷键为ALT+G，未测出效果
"nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration
"nmap <C-R>=expand("<cword>")<CR><CR>
"关键字补全
"let g:ycm_seed_identifiers_with_syntax = 1
" 在接受补全后不分裂出一个窗口显示接受的项
set completeopt-=preview
" 让补全行为与一般的IDE一致
set completeopt=longest,menu
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 每次重新生成匹配项，禁止缓存匹配项
let g:ycm_cache_omnifunc=0
" 在注释中也可以补全
let g:ycm_complete_in_comments=1
" 输入第一个字符就开始补全
let g:ycm_min_num_of_chars_for_completion=1
" 错误标识符
let g:ycm_error_symbol='>>'
" 警告标识符
let g:ycm_warning_symbol='>*'
" 不查询ultisnips提供的代码模板补全，如果需要，设置成1即可
" let g:ycm_use_ultisnips_completer=0


" pyhton mode 设置
" 使用python3版本
"let g:pymode_python = 'python3'
" 保存时去除多余空
"let g:pymode_trim_whitespaces = 1
"let g:pymode_rope_goto_definition_bind = "<C-]" 


let mapleader='`'
nmap <leader>p :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>f :Ag<CR>


