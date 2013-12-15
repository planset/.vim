" vimrc

augroup MyAutoCmd
  autocmd!
augroup END

" =============
" neobundle.vim
" =============
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
    " 読み込まない
    let s:noplugin = 1
else
    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#rc(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる
    NeoBundleFetch 'Shougo/neobundle.vim'

    " 非同期通信を可能にする
    " 'build'が指定されているのでインストール時に自動的に
    " 指定されたコマンドが実行され vimproc がコンパイルされる
    NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}
"    if has('mac')
"        let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_mac.so'
"    elseif has('win32')
"        let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_win32.dll'
"    elseif has('win64')
"        let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_win64.dll'
"    endif

    " ========
    " vimshell
    " ========
    NeoBundle 'Shougo/vimshell.git'
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    let g:vimshell_prompt =  '% '

    " =====
    " unite
    " =====
    NeoBundleLazy "Shougo/unite.vim", {
        \ "autoload": {
        \   "commands": ["Unite", "UniteWithBufferDir"]
        \ }}
    NeoBundleLazy 'h1mesuke/unite-outline', {
        \ "autoload": {
        \   "unite_sources": ["outline"],
        \ }}
    nnoremap [unite] <Nop>
    nmap U [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    let s:hooks = neobundle#get_hooks("unite.vim")
    function! s:hooks.on_source(bundle)
        " start unite in insert mode
        let g:unite_enable_start_insert = 1
        " use vimfiler to open directory
        call unite#custom_default_action("source/bookmark/directory", "vimfiler")
        call unite#custom_default_action("directory", "vimfiler")
        call unite#custom_default_action("directory_mru", "vimfiler")
        autocmd MyAutoCmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            imap <buffer> <Esc><Esc> <Plug>(unite_exit)
            nmap <buffer> <Esc> <Plug>(unite_exit)
            nmap <buffer> <C-n> <Plug>(unite_select_next_line)
            nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
            " 単語単位からパス単位で削除するように変更
            imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
            " 
            imap <silent><buffer> <C-t> <Tab>tabopen<CR>
            imap <silent> <C-t> unite#do_action('tabopen')
        endfunction
    endfunction

    NeoBundle 'ujihisa/unite-colorscheme.git'
    if globpath(&rtp, 'plugin/unite.vim') != ''
    nnoremap [unite]sc :<C-u>Unite colorscheme <Cr>
    endif

    NeoBundle 'hakobe/unite-script.git'


"    " ========
"    " vimfiler
"    " ========
"    NeoBundleLazy "Shougo/vimfiler", {
"        \ "depends": ["Shougo/unite.vim"],
"        \ "autoload": {
"        \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
"        \   "mappings": ['<Plug>(vimfiler_switch)'],
"        \   "explorer": 1,
"        \ }}
"    nnoremap <C-e> :VimFilerExplorer<CR>
"    " close vimfiler automatically when there are only vimfiler open
"    autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
"    let s:hooks = neobundle#get_hooks("vimfiler")
"    function! s:hooks.on_source(bundle)
"        let g:vimfiler_as_default_explorer = 1
"        let g:vimfiler_enable_auto_cd = 1
"        
"        "let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"
"        let g:vimfiler_ignore_pattern = "\%(^\.pyc$\)"
"
"        " vimfiler specific key mappings
"        autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
"        function! s:vimfiler_settings()
"            " ^^ to go up
"            nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
"            " use R to refresh
"            nmap <buffer> R <Plug>(vimfiler_redraw_screen)
"            " overwrite C-l
"            nmap <buffer> <C-l> <C-w>l
"        endfunction
"    endfunction

    " ===
    " Git
    " ===
    NeoBundleLazy "mattn/gist-vim", {
        \ "depends": ["mattn/webapi-vim"],
        \ "autoload": {
        \   "commands": ["Gist"],
        \ }}
    NeoBundle "tpope/vim-fugitive" " 遅延ロードができないらしい
    NeoBundleLazy "gregsexton/gitv", {
        \ "depends": ["tpope/vim-fugitive"],
        \ "autoload": {
        \   "commands": ["Gitv"],
        \ }}

    " =================
    " file,edit,search 
    " =================
    NeoBundle 'kien/ctrlp.vim'
    NeoBundle 'fuenor/qfixgrep.git'
    NeoBundle 'thinca/vim-qfreplace'

    NeoBundle 'tpope/vim-surround'
    " gettext 'foo' を _('foo') に、 "foo" を _("foo") 
    let g:surround_103 = "_('\r')"  " 103 = g
    let g:surround_71 = "_(\"\r\")" " 71 = G
    nmap g' cs'g
    nmap g" cs"G

    NeoBundle 'vim-scripts/Align'
    NeoBundle 'vim-scripts/YankRing.vim'
    NeoBundle 'ack.vim'

    " ========
    " NERDTree
    " ========
    NeoBundleLazy "scrooloose/nerdtree", {
        \ "autoload": {
        \   "commands": ["NERDTree", "NERDTreeToggle"],
        \ }}
    let file_name = expand("%:p")
    if has('vim_starting') &&  file_name == ""
        autocmd VimEnter * execute 'NERDTree ./'
    endif
    " CTRL + e : Toggle NERDTree window
    nnoremap <c-e> :<c-u>:NERDTreeToggle<cr>
    let s:hooks = neobundle#get_hooks("nerdtree")
    function! s:hooks.on_source(bundle)
        let NERDTreeIgnore = ['\.pyc$', '\.class$']
    endfunction


    " ===========
    " neocomplete
    " ===========
    if has('lua') && v:version >= 703 "&& has('patch885')
        NeoBundleLazy "Shougo/neocomplete.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        let s:hooks = neobundle#get_hooks("neocomplete.vim")
        let g:neocomplcache_enable_at_startup = 1
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplet#enable_smart_case = 1
            " NeoCompleteを有効化
            " NeoCompleteEnable
        endfunction
    else
        NeoBundleLazy "Shougo/neocomplcache.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        let g:neocomplcache_enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplcache.vim")
        function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_smart_case = 1
            " NeoComplCacheを有効化
            " NeoComplCacheEnable 
        endfunction
        "
        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        "inoremap <expr><C-e>  neocomplcache#cancel_popup()
    endif


    " =======
    " snippet
    " =======
    NeoBundleLazy "Shougo/neosnippet.vim", {
        \ "depends": ["honza/vim-snippets"],
        \ "autoload": {
        \   "insert": 1,
        \ }}
    let s:hooks = neobundle#get_hooks("neosnippet.vim")
    function! s:hooks.on_source(bundle)
        " Plugin key-mappings.
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)
        " SuperTab like snippets behavior.
        imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif
        " Enable snipMate compatibility feature.
        let g:neosnippet#enable_snipmate_compatibility = 1
        " Tell Neosnippet about the other snippets
        let g:neosnippet#snippets_directory = '~/.vim/snippets'
        imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-k>     <Plug>(neosnippet_expand_target)

        imap <C-K>     <Plug>(neosnippet_jump_or_expand)
        imap <C-s>  <Plug>(neosnippet_start_unite_snippet)

        command! -nargs=* Nes NeoSnippetEdit
        nnoremap <silent> <Space>es :<C-u>NeoSnippetEdit -split<CR>
    endfunction


    " ========================
    " html/javascript/css/scss
    " ========================
    NeoBundleLazy 'mattn/emmet-vim.git', {
        \ "autoload": {
        \   "filetypes": ["html", "djangohtml"]
        \ }}
    let s:hooks = neobundle#get_hooks("emmet-vim")
    function! s:hooks.on_source(bundle)
        let g:user_emmet_settings = {
            \  'lang' : 'ja',
            \  'html' : {
            \    'filters' : 'html',
            \    'indentation' : '  '
            \  },
            \  'css' : {
            \    'filters' : 'fc',
            \  },
            \ }
    endfunction
    NeoBundleLazy 'digitaltoad/vim-jade.git', {
        \ "autoload": {
        \   "filetypes": ["jade", "html", "djangohtml"]
        \ }}
    NeoBundleLazy 'hail2u/vim-css3-syntax.git', {
        \ "autoload": {
        \   "filetypes": ["css", "html", "djangohtml"]
        \ }}
    NeoBundleLazy 'cakebaker/scss-syntax.vim', {
        \ "autoload": {
        \   "filetypes": ["scss"]
        \ }}
    NeoBundleLazy 'pangloss/vim-javascript', {
        \ "autoload": {
        \   "filetypes": ["javascript", "typescript", "html", "djangohtml"]
        \ }}
    NeoBundleLazy 'leafgarland/typescript-vim', {
        \ "autoload": {
        \   "filetypes": ["typescript"]
        \ }}

    " ======
    " python
    " ======
    " Djangoを正しくVimで読み込めるようにする
    NeoBundleLazy "lambdalisue/vim-django-support", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"]
        \ }}
    " Vimで正しくvirtualenvを処理できるようにする
    NeoBundleLazy "jmcantrell/vim-virtualenv", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"]
        \ }}
    NeoBundleLazy "davidhalter/jedi-vim", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"],
        \ },
        \ "build": {
        \   "mac": "pip install jedi",
        \   "unix": "pip install jedi",
        \ }}
    let s:hooks = neobundle#get_hooks("jedi-vim")
    function! s:hooks.on_source(bundle)
        " jediにvimの設定を任せると'completeopt+=preview'するので
        " 自動設定機能をOFFにし手動で設定を行う
        let g:jedi#auto_vim_configuration = 0
        let g:jedi#popup_select_first = 0
        set completeopt=menuone

        let g:jedi#completions_command = "<C-n>"     " default is <leader>g
        "let g:jedi#auto_initialization = 1                " default is 1
        let g:jedi#goto_assignments_command = "<C-g>"     " default is <leader>g
        let g:jedi#goto_definitions_command = "<C-d>" " default is <leader>d
        "let g:jedi#documentation_command = "K"            " default is K
        "let g:jedi#use_tabs_not_buffers = 0               " default is 1
        let g:jedi#popup_on_dot = 0                       " default is 1
        "let g:jedi#rename_command = "<leader>r"           " default is <leader>r
        "let g:jedi#usages_command = "<leader>n"           " default is <leader>n
        "let g:jedi#show_call_signatures = 1               " default is 1
        "let g:jedi#function_definition_escape = "'≡'"     " default is '≡'
        "let g:jedi#auto_close_doc = 1                     " default is 1
        autocmd FileType python let b:did_ftplugin = 1
    endfunction

    NeoBundleLazy 'vim-scripts/python_fold.git', {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"]
        \ }}
    NeoBundleLazy 'nvie/vim-flake8', {
        \ "autoload": {
        \   "filetypes": ["python", "python3"]
        \ }}
    NeoBundleLazy 'alfredodeza/pytest.vim', {
        \ "autoload": {
        \   "filetypes": ["python", "python3"]
        \ }}
    let s:hooks = neobundle#get_hooks("pytest.vim")
    function! s:hooks.on_source(bundle)
        " ファイル全体に py.test を実行
        nmap <silent><Leader>tf <Esc>:Pytest file<CR>
        " フォーカスのあたってるクラスに py.test を実行
        nmap <silent><Leader>tc <Esc>:Pytest class<CR>
        " フォーカスのあたってるメソッドに py.test を実行
        nmap <silent><Leader>tm <Esc>:Pytest method<CR>
        " エラーメッセージなどのログウィンドウ表示をトグル
        nmap <silent><Leader>ts <Esc>:Pytest session<CR>
    endfunction

    " ====
    " ruby
    " ====
    NeoBundleLazy 'vim-ruby/vim-ruby', {
        \ 'autoload' : {
        \     'filetypes' : ['ruby']
        \ }}

    " ======
    " browse
    " ======
    NeoBundle 'yuratomo/w3m.vim'
    NeoBundle 'tyru/open-browser.vim.git'
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)

    " ===
    " etc
    " ===
    NeoBundleLazy 'vim-scripts/TwitVim.git', {
        \ "autoload": {
        \   "commands": ["PosttoTwitter", "FriendsTwitter", "UserTwitter",
        \                "RepliesTwitter", "NextTwitter", "ListTwitter"],
        \ }}
    nnoremap ,tp :<C-u>PosttoTwitter<CR>
    nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
    nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
    nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
    nnoremap ,tn :<C-u>NextTwitter<CR>
    nnoremap ,tl :<C-u>ListTwitter<space> 
    let s:hooks = neobundle#get_hooks("TwitVim")
    function! s:hooks.on_source(bundle)
        let twitvim_enable_python = 1
        let twitvim_count = 20

        autocmd FileType twitvim call s:twitvim_my_settings()
        function! s:twitvim_my_settings()
            "set nowrap
        endfunction
    endfunction

    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck
endif

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on


" =======================================================================
"
" vim settings
"
" =======================================================================

"" python path 
"let $PYTHON_DLL = "/opt/python2.7/lib/libpython2.7.dylib"

" Leader 
let mapleader = "\\"

" ウインドウの幅
"set columns=85
" ウインドウの高さ
"set lines=25
" コマンドラインの高さ(GUI使用時)
"set cmdheight=2
" カラースキーマ
"colorscheme zenburn
colorscheme desertEx

"
set colorcolumn=80
"新しい行のインデントを現在行と同じにする
"set autoindent
"新しい行を作ったときに高度な自動インデントを行う
"set smartindent
""タブの代わりに空白文字を挿入する
"set expandtab
"シフト移動幅
"set shiftwidth=4
"ファイル内の <Tab> が対応する空白の数
"set tabstop=4
"set softtabstop=4


set t_vb=             " スクリーンベルの無効化
set novisualbell      " スクリーンベルの無効化

set shiftround        " '<'や>でインデントする際にshiftwidthの倍数で丸める


"バックアップファイルを作るディレクトリ
set backupdir=$HOME/.vim/backup
"スワップファイル用のディレクトリ
set directory=$HOME/.vim/swap
"バックアップファイルを使わない
set nobackup
set nowritebackup
"スワップファイルを使わない
set noswapfile
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
if $TMUX == ''
    " YankRing
    if has('unnamedplus')
        set clipboard& clipboard+=unnamedplus,unnamed 
    else
        set clipboard& clipboard+=unnamed
    endif
endif
"Vi互換をオフ
set nocompatible
"変更中のファイルでも、保存しないで他のファイルを表示
"set hidden
"インクリメンタルサーチを行う
set incsearch
"タブ文字、行末など不可視文字を表示する
set list
"listで表示される文字のフォーマットを指定する
"set listchars=eol:$,tab:>\ ,extends:<
set listchars=tab:>\ 
"行番号を表示する
set number
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
""検索時に大文字を含んでいたら大/小を区別
set smartcase
""行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
""検索をファイルの先頭へループしない
set nowrapscan
" ヘルプファイルの位置を指定（？）
helptags ~/.vim/doc
"helptags ~/.vim/bundle/twitvim/doc
" ヘルプファイルの言語順
set helplang=ja,en
"他で編集されたら読み込み直す
set autoread

" setting font
if has('gui_running')
  " フォント設定:
  if has('win32')
    " Windows用
    set guifont=MS_Gothic:h12:cSHIFTJIS
    " 行間隔の設定
    set linespace=1
    " 一部のUCS文字の幅を自動計測して決める
    if has('kaoriya')
      set ambiwidth=auto
    endif
  elseif has('mac')
    set guifont=DejaVu\ Sans\ Mono:h13
    set guifontwide=ヒラギノ角ゴ\ ProN\ W6:h12
  elseif has('xfontset')
    " UNIX用 (xfontsetを使用)
    set guifontset=a14,r14,k14
  endif

  " Remove menu bar
  set guioptions-=m
  " Remove toolbar
  set guioptions-=T

  set lines=30 columns=90
  "set imdisable

endif 

"---------------------------------------------------------------------------
" 日本語入力に関する設定:
"
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " IME ON時のカーソルの色を設定(設定例:紫)
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定:
    " 下記の s-space はShift+Spaceの意味でkinput2+canna用設定
    "set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない場合、次行のコメントを解除
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
  set noimdisable
  set imdisableactivate
endif

"---------------------------------------------------------------------------
" マウスに関する設定:
"
" 解説:
" mousefocusは幾つか問題(一例:ウィンドウを分割しているラインにカーソルがあっ
" ている時の挙動)があるのでデフォルトでは設定しない。Windowsではmousehide
" が、マウスカーソルをVimのタイトルバーに置き日本語を入力するとチラチラする
" という問題を引き起す。
"
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)
"set guioptions+=a


"set ruler
set backspace=2

"ステータスラインの表示
let g:pythonworkon = "System"
py << EOF
import sys, os.path
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
    # Save virtual environment name to VIM variable
    vim.command("let g:pythonworkon = '%s'" % os.path.basename(project_base_dir))
EOF
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']['.pythonworkon.']'}%=%l,%c%V%8P

"exモードの補完
set wildmenu
set wildmode=list:longest,full

"補完
set complete=.,w,b,u,k
set pumheight=20


" タブバーを常に表示
set showtabline=2
" タブラインの設定
" from :help setting-tabline
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " 強調表示グループの選択
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " タブページ番号の設定 (マウスクリック用)
    "let s .= '%' . (i + 1) . 'T'

    " ラベルは MyTabLabel() で作成する
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " 最後のタブページの後は TabLineFill で埋め、タブページ番号をリセッ
  " トする
  "let s .= '%#TabLineFill#%T'

  " カレントタブページを閉じるボタンのラベルを右添えで作成
  "if tabpagenr('$') > 1
  "  let s .= '%=%#TabLine#%999Xclose'
  "endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return expand("#".buflist[winnr - 1].":t")
endfunction


" -------------
" encoding 
" -------------
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213
set fileformats=unix,mac,dos
set tenc=utf-8


"
" ファイル種別毎の設定
" .vim/ftplugin/*
"
"filetype on
"filetype plugin on

"
"
"
syntax enable
"syntax on

" teraterm でもカラー表示出来るように。
" teratermのTERATERM.INIのTermTypeをxterm-256colorにしてもOK
"set term=xterm-256color
"set ttytype=xterm-256color


"-----------------------------------------------------------------------
" キーマップ変更
"-----------------------------------------------------------------------
" map/noremap    normal mode
" nmap/nnoremap  normal mode
" imap/inoremap  insert mode
" cmap/cnoremap  command line mode 
" vmap/vnoremap  visual mode
" map!/noremap!  insert and command line mode

" .vimrcの編集
nnoremap <silent> <Space>er :tabe ~/.vimrc<CR>
" .vimrcのリロード
nnoremap <silent> <Space>rr :source ~/.vimrc<CR>

" jjでESC
inoremap jj <ESC>

" C-jでESC
inoremap <C-j> <ESC>
vnoremap <C-j> <ESC>
inoremap <C-[> <ESC>
vnoremap <C-[> <ESC>

"ビジュアルモードで選択して検索
vnoremap * "zy:let @/ = @z<CR>n

"ビジュアルモードで選択して置換。とりあえず/だけエスケープしとく
vnoremap <C-s> "zy:%s/<C-r>=ESCape(@z,'/')<CR>/

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後に検索単語を画面中央にする
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
"nnoremap * g*
"nnoremap # g#

" j, kの移動を表示ベースにする。
nnoremap j gj
nnoremap k gk

" Tabで対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" vvで行末まで選択
vnoremap v $h

" バッファの移動
nnoremap <F2> <ESC>:bp<CR>
nnoremap <F3> <ESC>:bn<CR>
nnoremap <F4> <ESC>:bw<CR>

" ウィンドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ウィンドウサイズの変更
nnoremap <C-Left> <C-w><<CR>
nnoremap <C-Right> <C-w>><CR>
nnoremap <C-Up> <C-w>-<CR>
nnoremap <C-Down> <C-w>+<CR>

" タブ間の移動
nnoremap <C-m> gt
nnoremap <C-n> gT
"nnoremap <C-h> gT
"nnoremap <C-l> gt

" 保存
nnoremap <Space>w :<C-u>write<Cr>
" w!! でsudo保存
cmap w!! %!sudo tee > /dev/null %
" 終了
nnoremap <Space>q :<C-u>quit<Cr>

" 貼り付け
inoremap <C-v> <ESC>"0pa
vnoremap <C-v> "0p

" インデントしたあと、インデントした行を再選択
vnoremap < <gv
vnoremap > >gv


" automatically reload vimrc when it's saved
"au BufWritePost .vimrc so ~/.vimrc


"inoremap <silent> <ESC> <ESC>:set iminsert=0<cr>



"pasteモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>

" ; -> :
nnoremap ; :



"
" input support
"
inoremap <C-e> <END>
inoremap <C-a> <HOME>
inoremap <C-f> <RIGHT>
inoremap <C-b> <LEFT>
inoremap <C-d> <Del>
inoremap <C-h> <BackSpace>

inoremap kj <Esc>

"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { {zdi{<C-R>z}<ESC>
"vnoremap [ [zdi[<C-R>z]<ESC>
"vnoremap ( (zdi(<C-R>z)<ESC>
"vnoremap " "zdi"<C-R>z"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

" カンマの後に空白を自動挿入 
"inoremap , , 

" git-diff-aware version of gf commands.
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('<C-w>gF') " gf
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('<C-w>gf') " gF
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

"nnoremap gf <C-w>gF
"nnoremap gF <C-w>gf

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if s:gfexists(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction

function! s:gfexists(target_path)
  if filereadable(a:target_path) || isdirectory(a:target_path)
    return 1
  endif
endfunction

function! s:openfile(target_path, line, opt)
  if strlen(a:target_path) > 0
    if a:opt == 'E'
      exe 'e ' . a:target_path
    elseif a:opt == 'S'
      exe 'sp ' . a:target_path
    elseif a:opt == 'V'
      exe 'vs ' . a:target_path
    elseif a:opt == 'T'
      exe 'tabe ' . a:target_path
    endif
    if a:line >= 0
      exe a:line . 'G'
    endif
    return 1
  else
    return 0
  endif
endfunction

function! s:do_flask_gf(target_path)
  if a:target_path =~# '\.html$'
    let target_path = 'templates/' . a:target_path
    if s:gfexists(target_path)
      return target_path
    endif
  endif
  return ''
endfunction

function! s:do_git_gf(target_path)
  if a:target_path =~# '^[ab]/' 
    return substitute(a:target_path, '^[ab]/', '', '')
  endif
  return ''
endfunction

function! s:do_custom_gf(opt)
  let rawpath = expand('<cfile>')
  let pathlist = split(rawpath, ':')
  let target_path = pathlist[0]
  let line = -1
  if len(pathlist) > 1
    let line = pathlist[1]
  endif

  if s:gfexists(target_path)
    call s:openfile(target_path, line, a:opt)
  elseif s:openfile(s:do_flask_gf(target_path), line, a:opt)
  elseif s:openfile(s:do_git_gf(target_path), line, a:opt)
  else
  endif
endfunction

nnoremap <silent> gbe :call <SID>do_custom_gf('E')<CR>
nnoremap <silent> gbs :call <SID>do_custom_gf('S')<CR>
nnoremap <silent> gbv :call <SID>do_custom_gf('V')<CR>
nnoremap <silent> gbt :call <SID>do_custom_gf('T')<CR>


" Surround.vimを拡張して"`を入力しないでも利用できるようにする
" 今日もどっこい生きている: surround.vimの拡張
" http://blog.ayakix.com/2012/05/surroundvim.html
nnoremap ci :call <sid>ExSurround("ci")<cr>
nnoremap di :call <sid>ExSurround("di")<cr>
function! s:ExSurround(cmd)
  let pattern = "'\"{[("
  let front = strpart(getline("."), 0, col("."))
  let max = -1
  for pat in split(pattern, '.\zs')
    let pos = strridx(front, pat)
    if pos > max
      let max = pos
    endif
  endfor
  if max >= 0
    let sorround = strpart(front, max, 1)
    call feedkeys(a:cmd . sorround, 'n')
  endif
endfunction</cr></sid></cr></sid>


"
" <Space>p : execute 
"
function! s:Exec()
  if &ft == 'javascript'
    exe "VimProcBang node " . " %"
  else
    exe "VimProcBang " . &ft . " %" 
  endif
:endfunction
command! Exec call <SID>Exec()
map <silent> <Space>p :call <SID>Exec()<CR>

"
" python helper
"
function! s:ExecPython3()
  exe "VimProcBang python3 %" 
:endfunction
command! ExecPython3 call <SID>ExecPython3()
nnoremap <silent> <Space>P :call <SID>ExecPython3()<CR>

function! s:ExecNose()
  exe "VimProcBang nosetests"
:endfunction
nnoremap <silent> <Space>@ :call <SID>ExecNose()<CR>

function! s:SphinxBuild()
  exe "VimProcBang make html; open _build/html/index.html"
:endfunction
command! SphinxBuild call <SID>SphinxBuild()
nnoremap <silent> <Space>sb :call <SID>SphinxBuild()<CR>

"
" Execute cursor line
"
function! s:ExecLine()
  exe "VimProcBang " . getline('.') 
endfunction
command! -nargs=* ExecLine :call <SID>ExecLine()
nnoremap <silent> <Space>lp :ExecLine<CR>

function! s:ExecLineRead()
  exe "VimProcRead " . getline('.') 
endfunction
command! -nargs=* ExecLineRead :call <SID>ExecLineRead()
nnoremap <silent> <Space>lr :ExecLineRead<CR>



"
" create directory automatically
"
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END



" =======================================================================
"
" plugin settings
"
" =======================================================================

"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" template
autocmd BufNewFile *.py 0r $HOME/.vim/template/template.python




"
" grep
"
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -n
command! -nargs=+ GrepCurDirAll call s:call_grep_curdirall(<q-args>)
function! s:call_grep_curdirall(args)"{{{
  exec "grep -n -d recurse " . a:args . " **/*.*"  | cw 
  "let [l:args, l:options] = s:parse_options_args(a:args)
  "call unite#start(l:args, l:options)
endfunction"}}}
noremap ,g :<C-u>GrepCurDirAll<space>


" 
" GetKeyword 
" カーソル化の文字列をベースに入力エリアを表示してキーワードを確定する。
" 取得した文字列を使って検索したりしましょ
"
function! s:GetKeyword()
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.' '
  let word = len(a:000) == 0 ? input('Keywords: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  return word
endfunction
function! s:ReplaceSpaceToPlus(word)
  return substitute(a:word, ' ', '+', 'g')
endfunction
nnoremap <silent> gs :call <SID>ReplaceSpaceToPlus()<CR>

"
" ぐぐる
"
function! s:SearchGoogleVSplit()
  let keyword = s:GetKeyword()
  if keyword == ""
    return
  endif
  keyword = s:ReplaceSpaceToPlus(keyword)
  exe 'W3mVSplit http://google.co.jp/search?q=' . keyword
:endfunction
function! s:SearchGoogleTab()
  let keyword = s:GetKeyword()
  if keyword == ""
    return
  endif
  keyword = s:ReplaceSpaceToPlus(keyword)
  exe 'W3mTab http://google.co.jp/search?q=' . keyword
:endfunction
nnoremap <silent> gr :call <SID>SearchGoogleVSplit()<CR>
nnoremap <silent> gR :call <SID>SearchGoogleTab()<CR>


"
" for Dash
"
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)
nnoremap <silent> <space>d :Dash<cr>


"
" input support
"
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" １つ前にペーストした内容を選択する。
" codeを複数行dd, pしたあと、インデントを変えるときにちょー便利
nnoremap gc `[v`]
vnoremap gc :<C-u>normal gc<Enter>
onoremap gc :<C-u>normal gc<Enter>

command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932



" 参考にした資料
" 
" `Vimを最強のPython開発環境にする2 - Λlisue's blog
" <http://lambdalisue.hatenablog.com/entry/2013/06/23/071344>`_
"
" 他にも色々。
"
