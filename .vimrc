"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"

" autoclose
" NeoBundle 'Townk/vim-autoclose'

" syntastic
NeoBundle 'scrooloose/syntastic'

" jsonシンタックス
NeoBundle 'elzr/vim-json'

" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
let g:indent_guides_guide_size = 1

" かっこいいカラースキーマ
NeoBundle 'w0ng/vim-hybrid'

" Slim用シンタックス
NeoBundle "slim-template/vim-slim"

" 空白の可視化
NeoBundle 'bronson/vim-trailing-whitespace'

" coffee
NeoBundle 'kchmck/vim-coffee-script'

" railsに超便利
NeoBundle 'tpope/vim-rails'

" 入力補完
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'

" ファイラー
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

" 複数ファイル置き換え
NeoBundle 'thinca/vim-qfreplace'

" ステータスラインをかっこよくする
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'

" Ruby向けにendを自動挿入してくれる
NeoBundle 'tpope/vim-endwise'

" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" ドキュメント参照
NeoBundle 'thinca/vim-ref'
" NeoBundle 'yuku-t/vim-ref-ri'

NeoBundle 'kana/vim-fakeclip'

NeoBundle 'digitaltoad/vim-pug'
NeoBundle 'posva/vim-vue'
NeoBundleLazy 'othree/yajs.vim', {'autoload':{'filetypes':['javascript']}}

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck
"-------------------------
" End Neobundle Settings.
"-------------------------


"-------------------------
" General Settings.
"-------------------------

" for json
let g:vim_json_syntax_conceal = 0

set background=dark
colorscheme hybrid

syntax on

set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set expandtab
set smarttab
set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2
set cursorline
set number
set showmatch
set incsearch
set noswapfile
set swapfile
set directory=/tmp
set backup
set backupdir=/tmp
set undofile
set undodir=/tmp
set clipboard=unnamed

set backspace=indent,eol,start

" txtの自動改行解除
autocmd FileType text setlocal textwidth=0

" phpはハードタブで
au BufNewFile,BufRead *.php setlocal noexpandtab ts=4 sw=4

" coffee用
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee


"-------------------------
" LightLine
"-------------------------

set laststatus=2
let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'


"-------------------------
" vim-trailing-whitespace
"-------------------------

" 行末の空白を保存時に削除
fun! FixWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
      return
  endif
  :FixWhitespace
endfun
aug space
  au!
  autocmd BufWritePre * call FixWhitespace()
aug END


"-------------------------
" NeoComplcache
"-------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


"-------------------------
" NeoSnippet
"-------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


"-------------------------
" Unite
"-------------------------

" Unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,y :<C-u>Unite history/yank<CR>
nnoremap <silent> ,b :<C-u>Unite buffer<CR>
nnoremap <silent> ,f :<C-u>Unite file<CR>
nnoremap <silent> ,c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,u :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" unite grepにptを使う
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif


"-------------------------
" vimfiler
"-------------------------

nnoremap <silent> ,e :<C-u>:VimFilerExplore -split -winwidth=30 -find -no-quit<CR>


"-------------------------
" vim-ref
"-------------------------

let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス
