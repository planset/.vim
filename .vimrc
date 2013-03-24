"
" neobundle.vim
"
set nocompatible

if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" original repos on github
NeoBundle 'Shougo/vimproc.git', { 'build' : {
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \     },
    \  }
NeoBundle 'Shougo/vimshell.git'
"NeoBundle 'vim-scripts/sudo.vim.git'

" unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline.git'
NeoBundle 'ujihisa/unite-colorscheme.git'
NeoBundle 'hakobe/unite-script.git'
NeoBundle 'Shougo/vimfiler'

NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'fuenor/qfixgrep.git'
NeoBundle 'thinca/vim-qfreplace'
"NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim.git'
"NeoBundle 'altercation/vim-colors-solarized.git'

" neocomple
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet'
"NeoBundle 'vim-scripts/pythoncomplete.git'
"NeoBundle 'msanders/snipmate.vim'

" html/javascript/css/scss
NeoBundle 'mattn/zencoding-vim.git'
NeoBundle 'digitaltoad/vim-jade.git'
NeoBundle 'hail2u/vim-css3-syntax.git'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'leafgarland/typescript-vim'

"NeoBundle 'vim-scripts/TwitVim.git'

" python
"NeoBundle 'thinca/vim-ref.git'
"NeoBundle 'fs111/pydoc.vim'
NeoBundle 'vim-scripts/python_fold.git'
NeoBundle 'reinh/vim-makegreen'
NeoBundle 'lambdalisue/nose.vim'
NeoBundle 'lambdalisue/vim-django-support'
NeoBundle 'mitechie/pyflakes-pathogen'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'sontek/rope-vim'

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'

" file selector
NeoBundle 'kien/ctrlp.vim'

filetype plugin indent on

NeoBundleCheck


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
set nobackup
set nowritebackup
"スワップファイルを使わない
set noswapfile
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

nnoremap <silent> <Space>er  :tabe ~/.vimrc<CR>

nnoremap <F2> <ESC>:bp<CR>
nnoremap <F3> <ESC>:bn<CR>
nnoremap <F4> <ESC>:bw<CR>


inoremap <C-j> <ESC>
vnoremap <C-j> <ESC>
inoremap <C-[> <ESC>
vnoremap <C-[> <ESC>

nnoremap <Space>w :<C-u>write<Cr>
nnoremap <Space>q :<C-u>quit<Cr>

inoremap <C-v> <ESC>"0pa
vnoremap <C-v> "0p
nnoremap * g*
nnoremap # g#

vnoremap < <gv
vnoremap > >gv

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-m> gt
nnoremap <C-n> gT

"nnoremap <C-h> gT
"nnoremap <C-l> gt

cmap w!! %!sudo tee > /dev/null %

" automatically reload vimrc when it's saved
"au BufWritePost .vimrc so ~/.vimrc


"inoremap <silent> <ESC> <ESC>:set iminsert=0<cr>

"ビジュアルモードで選択して検索
vnoremap * "zy:let @/ = @z<CR>n

"ビジュアルモードで選択して置換。とりあえず/だけエスケープしとく
vnoremap <C-s> "zy:%s/<C-r>=ESCape(@z,'/')<CR>/


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
  exe "VimProcBang " . &ft . " %" 
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
let g:neocomplcache_ignore_composite_filetype = {
  \'python.unit': 'python',
\}
"if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.python = ''


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

nnoremap <silent> <Space>es  :<C-u>NeoComplCacheEditSnippets<CR> 

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" neosnippets
let g:neosnippet#snippets_directory = '~/.vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <C-K>     <Plug>(neosnippet_jump_or_expand)
imap <C-s>  <Plug>(neosnippet_start_unite_snippet)

command! -nargs=* Nes NeoSnippetEdit
nnoremap <silent> <Space>es :<C-u>NeoSnippetEdit -split<CR>

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

nnoremap <silent> <Space>f :<C-u>Unite -buffer-name=files file file_mru<CR>
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
nnoremap <silent> <Space>up :<C-u>Unite ref/pydoc<CR>

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


""
"" twitvim
"" 
"let twitvim_count = 40
"nnoremap ,tp :<C-u>PosttoTwitter<CR>
"nnoremap ,tf :<C-u>FriendsTwitter<CR><C-w>j
"nnoremap ,tu :<C-u>UserTwitter<CR><C-w>j
"nnoremap ,tr :<C-u>RepliesTwitter<CR><C-w>j
"nnoremap ,tn :<C-u>NextTwitter<CR>
"nnoremap ,tl :<C-u>ListTwitter<space> 
"
"autocmd FileType twitvim call s:twitvim_my_settings()
"function! s:twitvim_my_settings()
"  set nowrap
"endfunction


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
nnoremap <c-e> :<c-u>:NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pyc$', '\.class$']


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
" vimshell
"
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '% '


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

"
" open-browser.vim
" http://vim-users.jp/2011/08/hack225/
"
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

""
"" taglist-vim
""
"nnoremap <silent> <Space>tt :TlistToggle<CR><C-w><C-w>

"
" jedi-vim
" commit: a87af78be3ffffb27dc556937f34f34e2a8491dc
"
let g:jedi#auto_initialization = 1              " default is 1
let g:jedi#goto_command = "<C-d>"               " default is <leader>g
let g:jedi#get_definition_command = "<leader>d" " default is <leader>d
let g:jedi#pydoc = "K"                          " default is K
let g:jedi#use_tabs_not_buffers = 0             " default is 1
let g:jedi#popup_on_dot = 0                     " default is 1
let g:jedi#rename_command = "<leader>r"         " default is <leader>r
let g:jedi#related_names_command = "<leader>n"  " default is <leader>n
let g:jedi#show_function_definition = 1         " default is 1
"let g:jedi#function_definition_escape = "'≡'"   " default is '≡'
"let g:jedi#auto_close_doc = 1                   " default is 1
autocmd FileType python let b:did_ftplugin = 1



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



