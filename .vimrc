"
" vundle
"
set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" original repos on github
Bundle 'Shougo/vimproc.git'
Bundle 'Shougo/vimshell.git'
Bundle 'vim-scripts/sudo.vim.git'

Bundle 'scrooloose/nerdtree.git'
Bundle 'fuenor/qfixgrep.git'

Bundle 'Shougo/unite.vim.git'
Bundle 'h1mesuke/unite-outline.git'
Bundle 'ujihisa/unite-colorscheme.git'
Bundle 'hakobe/unite-script.git'

Bundle 'Shougo/neocomplcache.git'
Bundle 'Shougo/neocomplcache-snippets-complete.git'
Bundle 'vim-scripts/pythoncomplete.git'
"Bundle 'msanders/snipmate.vim'

Bundle 'mattn/zencoding-vim.git'
Bundle 'digitaltoad/vim-jade.git'

Bundle 'vim-scripts/TwitVim.git'

Bundle 'thinca/vim-ref.git'

Bundle 'vim-scripts/python_fold.git'
Bundle 'reinh/vim-makegreen'
Bundle 'lambdalisue/nose.vim'
Bundle 'lambdalisue/vim-django-support'
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'nvie/vim-flake8'

Bundle 'vim-scripts/taglist.vim'
Bundle 'fs111/pydoc.vim'

Bundle 'sontek/rope-vim'
Bundle 'tpope/vim-surround'

filetype plugin indent on


" =======================================================================
"
" vim settings
"
" =======================================================================

" leader 
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

"バックアップファイルを作るディレクトリ
set backupdir=$HOME/.vim/backup
"スワップファイル用のディレクトリ
set directory=$HOME/.vim/swap
"バックアップファイルを使わない
"set nobackup
"スワップファイルを使わない
"set noswapfile
"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer
"クリップボードをWindowsと連携
set clipboard=unnamed
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
    set guifont=DejaVu\ Sans\ Mono:h12
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
  "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
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
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
nnoremap gf <C-w>gf

inoremap <C-j> <esc>
vnoremap <C-j> <esc>
inoremap <C-[> <esc>
vnoremap <C-[> <esc>

nnoremap <Space>w :<C-u>write<Cr>
nnoremap <Space>q :<C-u>quit<Cr>

nnoremap * g*
nnoremap # g#

nnoremap <C-l> gt
nnoremap <C-h> gT

inoremap <silent> <esc> <esc>:set iminsert=0<cr>

"ビジュアルモードで選択して検索
vnoremap * "zy:let @/ = @z<CR>n

"ビジュアルモードで選択して置換。とりあえず/だけエスケープしとく
vnoremap <C-s> "zy:%s/<C-r>=escape(@z,'/')<CR>/

"入力モードで削除
inoremap <C-d> <Del>
inoremap <C-h> <BackSpace>

"pasteモードトグル
nnoremap <Space>tp :<C-u>set paste!<CR>

" ; -> :
nnoremap ; :


"
" <Space>p : execute 
"
function! s:Exec()
  exe "VimProcBang " . &ft . " %" 
:endfunction
command! Exec call <SID>Exec()
map <silent> <Space>p :call <SID>Exec()<CR>

function! s:ExecNose()
  exe "VimProcBang nosetests"
:endfunction
map <silent> <Space>@ :call <SID>ExecNose()<CR>

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

"
" neocomplcache
" 
" スニペットファイルの配置場所
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_dictionary_filetype_lists = {
  \'default':'',
  \'vimshell':$HOME.'/.vimshell_hist',
\}

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
inoremap <expr><C-e>  neocomplcache#cancel_popup()

nnoremap <silent> <Space>es  :<C-u>NeoComplCacheEditSnippets<CR> 

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags



" neocomplecache_snippets_complete
let g:neocomplecache_snippets_dir = '~/.vim/snippets'
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
command! -nargs=* Nes NeoComplCacheEditSnippets

"
" zencoding
"
let g:user_zen_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : '  '
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \ }



"
" unite.vim
"
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

nnoremap <silent> <Space>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"inoremap <silent> <C-f> <ESC>:<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>b :<C-u>Unite buffer file_mru<CR>
"inoremap <silent> <C-b> <ESC>:<C-u>Unite buffer file_mru<CR>
nnoremap <silent> <Space>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" pydoc
nnoremap <silent> ,up :<C-u>Unite ref/pydoc<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  "inoremap <buffer> <C-l> <C-x><C-u><C-p><Down>

  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " 
  imap <silent><buffer> <C-t> <Tab>tabopen<CR>
  imap <silent> <C-t> unite#do_action('tabopen')
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction


"
" unite-colorscheme
"
if globpath(&rtp, 'plugin/unite.vim') != ''
  nnoremap sc :<C-u>Unite colorscheme <Cr>
endif


"
" unite outline
"
nnoremap <silent> <Space>o :<C-u>Unite outline<CR>


"
" twitvim
" 
let twitvim_count = 40
nnoremap ,tp :<C-u>PosttoTwitter<CR>
nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
nnoremap ,tn :<C-u>NextTwitter<CR>
nnoremap ,tl :<C-u>ListTwitter<space> 

autocmd FileType twitvim call s:twitvim_my_settings()
function! s:twitvim_my_settings()
  set nowrap
endfunction


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
" NERDTree
"
" When you run vim with no args, vim runs the NERDTree.
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * execute 'NERDTree ./'
endif
" CTRL + e : Toggle NERDTree window
noremap <c-e> :<c-u>:NERDTreeToggle<cr>


"
" vim-flake8
"
"autocmd FileType python call s:python_settings()
"function! s:python_settings()
"  autocmd BufWritePost <buffer> call Flake8()
"endfunction

"
" vimproc
"
if has('mac')
  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_mac.so'
elseif has('win32')
  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_win32.dll'
elseif has('win64')
  let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/vimproc_win64.dll'
endif


"
" pydoc
"
" nnoremap <silent> <buffer> K :call <SID>ShowPyDoc(<SID>ExpandModulePath(), 1)<CR>
"

"
" surround.vim
"
" gettext 'foo' を _('foo') に、 "foo" を _("foo") 
let g:surround_103 = "_('\r')"  " 103 = g
let g:surround_71 = "_(\"\r\")" " 71 = G
nmap g' cs'g
nmap g" cs"G


