" vimconf is not vi-compatible
set nocompatible

" Automatically make needed files and folders on first run
" If you don't run *nix you're on your own (as in remove this) {
    call system("mkdir -p $HOME/.vim/{plugin,swap,undo,tags}")
" }
" Vundle plugin manager {
    " Automatically setting up Vundle, taken from
    " http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/ {
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
            let has_vundle=0
        endif
    " }
    " Initialize Vundle {
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    " }
    " Github repos, uncomment to disable a plugin {
    Plugin 'gmarik/Vundle.vim'

    " COMMANDS
    Plugin 'Lokaltog/vim-easymotion'        " Easy... motions... yeah.
    Plugin 'tpope/vim-repeat'               " repeat.vim: enable repeating supported plugin maps with '.'
    Plugin 'terryma/vim-multiple-cursors'   " True Sublime Text style multiple selections for Vim
    Plugin 'matchit.zip'                    " extended % matching for HTML, LaTeX, and many other languages

    " SEARCH
    Plugin 'kien/ctrlp.vim'                 " Fuzzy finder (files, mru, etc)
    Plugin 'tacahiroy/ctrlp-funky'          " Very simple function navigator for ctrlp.vim
    Plugin 'rking/ag.vim'                   " Vim plugin for the_silver_searcher, 'ag'
    "Plugin 'mileszs/ack.vim'                " Vim plugin for the Perl module / CLI script 'ack'

    " INTERFACE
    Plugin 'mhinz/vim-startify'             " A fancy start screen, shows MRU etc.
    Plugin 'bling/vim-airline'              " lean & mean status/tabline for vim that's light as air
    Plugin 'majutsushi/tagbar'              " Functions, class data etc.
    Plugin 'scrooloose/nerdtree'            " A tree explorer plugin for vim.
    Plugin 'sjl/gundo.vim'                  " Undo tree

    " COLORS
    "Plugin 'altercation/vim-colors-solarized'
    Plugin 'flazz/vim-colorschemes'

    " VCS
    "Plugin 'mhinz/vim-signify'              " Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
    Plugin 'airblade/vim-gitgutter'         " Shows a git diff in the gutter (sign column) and stages/reverts hunks.
    Plugin 'tpope/vim-fugitive'             " Git wrapper inside Vim

    " COMPLETION
    " Plugin 'tpope/vim-surround'             " surround.vim: quoting/parenthesizing made simple
    Plugin 'Raimondi/delimitMate'           " Provides Sublime-Text like smart completion of braces, parens and such
    Plugin 'Valloric/YouCompleteMe'
    "Plugin 'ervandew/supertab'              " <Tab> everything!
    " Snippets
    Plugin 'SirVer/ultisnips'               " Snippet engine
    Plugin 'honza/vim-snippets'
    "Plugin 'garbas/vim-snipmate'
    Plugin 'tpope/vim-surround'             " Surround is useful for adding surrounding tags to elements (especially html)

    " EDITING
    Plugin 'godlygeek/tabular'               " Align your = etc.
    Plugin 'scrooloose/nerdcommenter'        " Super easy commenting, toggle comments etc
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'tpope/vim-abolish.git'           " Custom search and replace tool
    Plugin 'kana/vim-textobj-user'           " Vim plugin: Create your own text objects
    Plugin 'wellle/targets.vim'              " Text object target
    Plugin 'gcmt/wildfire.vim'               " Smart selection of the closest text object
    Plugin 'osyo-manga/vim-over'             " :substitute preview

    " WRITTING
    Plugin 'reedes/vim-litecorrect'
    Plugin 'reedes/vim-textobj-sentence'
    Plugin 'reedes/vim-textobj-quote'
    Plugin 'reedes/vim-wordy'

    " LANGUAGE
    " General
    Plugin 'scrooloose/syntastic'           " Awesome syntax checker.
    " Javascript
    Plugin 'pangloss/vim-javascript'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'wookiehangover/jshint.vim'
    " PHP
    Plugin 'arnaud-lb/vim-php-namespace'
    " Go
    Plugin 'fatih/vim-go'
    " Python
    Plugin 'klen/python-mode'               " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box.
    Plugin 'yssource/python.vim'
    Plugin 'python_match.vim'
    Plugin 'pythoncomplete'
    " Markdown
    Plugin 'tpope/vim-markdown'
    " HTML5
    Plugin 'othree/html5.vim'               " HTML5 omnicomplete and syntax
    Plugin 'amirh/HTML-AutoCloseTag'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'gorodinskiy/vim-coloresque'
    Plugin 'tpope/vim-haml'
    " Json
    Plugin 'elzr/vim-json'
    " Less
    Plugin 'groenewege/vim-less'
    " Haskell
    Plugin 'eagletmt/ghcmod-vim'
    Plugin 'eagletmt/neco-ghc'          " A completion plugin for Haskell, using ghc-mod

    " DEBUGGING
    Plugin 'joonty/vdebug'              " Go to files

    " FILES
    Plugin 'justinmk/vim-gtfo'              " Go to files

    " SESSIONS
    Plugin 'vim-scripts/sessionman.vim'

    " Finish Vundle stuff
    call vundle#end()

    " Installing plugins the first time, quits when done {
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    " }
" }
" Local leading config, only use for prerequisites as it will be
" overwritten by anything below {{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
" }
" User interface {
    " Syntax highlighting {
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set background=dark                         " we're using a dark bg
        colorscheme jellybeans                      " colorscheme from plugin
        " .txt w/highlight, plaintex is useless, markdown for .md {
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
            augroup END
        " }
        " 256 colors for maximum jellybeans bling. See commit log for info {
            if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            endif
        " }
    " }
    " Interface general {
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
                    \*.jpeg,*.png,*.gif,*.pdf,*.git,
                    \*.swp,*.swo                    " tab completion ignores
        set wildmenu                                " better auto complete
        set wildmode=list:longest,full              " bash-like auto complete
        " Depending on your setup you may want to enforce UTF-8.
        " Should generally be set in your environment LOCALE/$LANG {
            " set encoding=utf-8                    " default $LANG/latin1
            " set fileencoding=utf-8                " default none
        " }
        " Gvim {
            set guifont=DejaVu\ Sans\ Mono\ 9
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        " }
    " }
" }
" General settings {
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    "set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    set ttymouse=xterm2                             " experimental
    set shellpipe=2>/dev/null>                      " Don't dump distracting text to terminal during searches!
    set pastetoggle=<F3>                            " Toggle pastemode, doesn't indent
    set colorcolumn=+1                              " Column width indicator
    " Folding {
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    " }
    " Search and replace {
        set ignorecase                              " Case insensitive search
        set smartcase                               " Non-case sensitive search
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
        set hlsearch                                " Highlight search results
    " }
    " Matching {
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    " }
    " Return to last edit position when opening files {
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    " }
" }
" Files {
    "set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups
    " Persistent undo. Requires Vim 7.3 {
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    " }
    " Swap files, unless vim is invoked using sudo. Inspired by tejr's vimrc
    " https://github.com/tejr/dotfiles/blob/master/vim/vimrc {
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            " Don't swap tmp, mount or network dirs {
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                                \ setlocal noswapfile
                augroup END
            " }
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    " }
" }
" Text formatting {
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
    " Only auto-comment newline for block comments {
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    " }
    " Take comment leaders into account when joining lines, :h fo-table
    " http://ftp.vim.org/pub/vim/patches/7.3/7.3.541 {
        if has("patch-7.3.541")
            set formatoptions+=j
        endif
    " }
" }
" Keybindings {
    " General {
        " Remap <leader>
        let mapleader=","

        " Yank from the cursor to the end of the line, to be consistent with C and D.
        nnoremap Y y$

        " Yank entire buffer with gy
        nnoremap gy :%y+<cr>

        " Select entire buffer
        nnoremap vy ggVG

        " Toggle folding
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf
        " Close the current window
        nnoremap <silent> <m-w> :close<CR>

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Scroll up/down lines from 'scroll' option, default half a screen
        map <C-j> <C-d>
        map <C-k> <C-u>

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " Let's make escape better, together.
        inoremap jk <Esc>
        inoremap JK <Esc>
        inoremap Jk <Esc>
        inoremap jK <Esc>

        " Use very magic (Perl-like) regex style
        "nnoremap / /\v
        "vnoremap / /\v

        " Working ci(, works for both breaklined, inline and multiple ()
        nnoremap ci( %ci(

        " We don't need any help!
        inoremap <F1> <nop>
        nnoremap <F1> <nop>
        vnoremap <F1> <nop>

        " Disable annoying ex mode (Q)
        map Q <nop>

        " shortcuts for windows
        nnoremap <leader>v <C-w>v<C-w>l
        nnoremap <leader>s <C-w>s
        nnoremap <leader>vsa :vert sba<cr>
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l

        " Buffers, preferred over tabs now with bufferline.
        nnoremap gn :bnext<CR>
        nnoremap gN :bprevious<CR>
        nnoremap gd :bdelete<CR>
        nnoremap gf <C-^>

        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        cmap cd. lcd %:p:h

        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv

        " Allow using the repeat operator with a visual selection (!)
        " http://stackoverflow.com/a/8064607/127816
        vnoremap . :normal .<CR>

        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null

        " Leader {
            " Fold levels
            nmap <leader>f0 :set foldlevel=0<CR>
            nmap <leader>f1 :set foldlevel=1<CR>
            nmap <leader>f2 :set foldlevel=2<CR>
            nmap <leader>f3 :set foldlevel=3<CR>
            nmap <leader>f4 :set foldlevel=4<CR>
            nmap <leader>f5 :set foldlevel=5<CR>
            nmap <leader>f6 :set foldlevel=6<CR>
            nmap <leader>f7 :set foldlevel=7<CR>
            nmap <leader>f8 :set foldlevel=8<CR>
            nmap <leader>f9 :set foldlevel=9<CR>

            " Paste in new line
            nmap <leader>p o<ESC>p

            " Clear search
            noremap <silent><leader>/ :nohls<CR>

            " Highlight search word under cursor without jumping to next
            nnoremap <leader>h *<C-O>

            " Toggle spelling mode with ,s
            nnoremap <silent> <leader>s :set spell!<CR>

            " Quickly switch to last buffer
            nnoremap <leader>, :e#<CR>

            " Underline the current line with '-'
            nnoremap <silent> <leader>ul :t.\|s/./-/\|:nohls<cr>

            " Underline the current line with '='
            nnoremap <silent> <leader>uul :t.\|s/./=/\|:nohls<cr>

            " Surround the commented line with lines.
            "
            " Example:
            "          # Test 123
            "          becomes
            "          # --------
            "          # Test 123
            "          # --------
            nnoremap <silent> <leader>cul :normal "lyy"lpwvLr-^"lyyk"lP<cr>

            " Format the entire file
            nnoremap <leader>fef mx=ggG='x

            " Format a json file with Python's built in json.tool.
            " from https://github.com/spf13/spf13-vim/blob/3.0/.vimrc#L390
            nnoremap <leader>jt <Esc>:%!underscore print<CR><Esc>:set filetype=json<CR>
            nnoremap <leader>jts <Esc>:%!underscore print --strict<CR><Esc>:set filetype=json<CR>

            " Split window vertically or horizontally *and* switch to the new split!
            nnoremap <silent> <leader>hs :split<Bar>:wincmd j<CR>
            nnoremap <silent> <leader>vs :vsplit<Bar>:wincmd l<CR>

            " Yank(copy) to system clipboard
            noremap <leader>y "+y

            " Find merge conflict markers
            map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

        " }
    " }
    " Functions or fancy binds {{
        " Toggle syntax highlighting {
            function! ToggleSyntaxHighlighthing()
                if exists("g:syntax_on")
                    syntax off
                else
                    syntax on
                endif
            endfunction

            nnoremap <leader>s :call ToggleSyntaxHighlighthing()<CR>
        " }
        " Toggle relativenumber using <leader>r {
            function! NumberToggle()
                if(&relativenumber == 1)
                    set number
                else
                    set relativenumber
                endif
            endfunction

            nnoremap <leader>r :call NumberToggle()<CR>
        " }
        " Toggle text wrapping, wrap on whole words
        " For more info see: http://stackoverflow.com/a/2470885/1076493 {
            function! WrapToggle()
                if &wrap
                    set list
                    set nowrap
                else
                    set nolist
                    set wrap
                endif
            endfunction

            nnoremap <leader>w :call WrapToggle()<CR>
        " }
        " Remove multiple empty lines {
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction

            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>
        " }
        " Split to relative header/source {
            function! SplitRelSrc()
                let s:fname = expand("%:t:r")

                if expand("%:e") == "h"
                    set nosplitright
                    exe "vsplit" fnameescape(s:fname . ".cpp")
                    set splitright
                elseif expand("%:e") == "cpp"
                    exe "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction

            nnoremap <leader>le :call SplitRelSrc()<CR>
        " }
        " Strip trailing whitespace, return to cursor at save {
            function! <SID>StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl
                            \ autocmd BufWritePre <buffer> :call
                            \ <SID>StripTrailingWhitespace()
            augroup END

            nnoremap <leader>ls :call <SID>StripTrailingWhitespace()<CR>
        " }
    " }
" }
" Plugin settings {
    " TextObj Sentence {
        augroup textobj_sentence
            autocmd!
            autocmd FileType markdown call textobj#sentence#init()
            autocmd FileType textile call textobj#sentence#init()
            autocmd FileType text call textobj#sentence#init()
        augroup END
    " }

    " TextObj Quote {
        augroup textobj_quote
            autocmd!
            autocmd FileType markdown call textobj#quote#init()
            autocmd FileType textile call textobj#quote#init()
            autocmd FileType text call textobj#quote#init({'educate': 0})
        augroup END
    " }

    " Misc {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            let g:NERDShutUp=1
        endif
        if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

    " Ctags {
        set tags=./tags,tags;/,~/.vim/tags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " Tabularize {
        if isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /=<CR>
            vmap <Leader>a= :Tabularize /=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'rw'
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            if executable('ag')
                " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
                let g:ctrlp_user_command =
                            \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

                " ag is fast enough that CtrlP doesn't need to cache
                let g:ctrlp_use_caching = 0
            else
                " Fall back to using git ls-files if Ag is not available
                let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
                let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
            endif

            " Default to filename searches - so that appctrl will find application
            " controller
            let g:ctrlp_by_filename = 1

            " Don't jump to already open window. This is annoying if you are maintaining
            " several Tab workspaces and want to open two windows into the same file.
            let g:ctrlp_switch_buffer = 0

            " Mappings
            nmap <leader>l :CtrlP
            nmap <leader>lw :CtrlP<CR><C-\>w
            vmap <leader>lw :CtrlP<CR><C-\>v

            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                " funky
                nnoremap <Leader>lf :CtrlPFunky<Cr>
                " narrow the list down with a word under cursor
                nnoremap <Leader>lfw :execute 'CtrlPFunky ' .  expand('<cword>')<Cr>>)
            endif
        endif
    "}

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tb :TagbarToggle<CR>

            " If using go please install the gotags program using the following
            " go install github.com/jstemmer/gotags
            " And make sure gotags is in your path
            let g:tagbar_type_go = {
                \ 'ctagstype' : 'go',
                \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                    \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                    \ 'r:constructor', 'f:functions' ],
                \ 'sro' : '.',
                \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
                \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
                \ 'ctagsbin'  : 'gotags',
                \ 'ctagsargs' : '-sort -silent'
                \ }
        endif
    "}

    " Fugitive {
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

    " YouCompleteMe {
        if isdirectory(expand("~/.vim/bundle/YouCompleteMe/"))
            " enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_seed_identifiers_with_syntax        = 1 " completion for language keyword
            let g:ycm_complete_in_comments                = 0 " Completion in comments
            let g:ycm_complete_in_strings                 = 1 " Completion in string
            let g:ycm_min_num_identifier_candidate_chars  = 2
            let g:ycm_semantic_triggers = {'haskell' : ['.']}

            " remap Ultisnips for compatibility for YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            if has('conceal')
                set conceallevel=2 concealcursor=i
            endif

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview

        endif
    " }

    " vim-airline {
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
    " }

    " Syntastic {
        " Toggle error list. Probably should be toggleable.
        noremap <silent><leader>lo :Errors<CR>
        noremap <silent><leader>lc :lcl<CR>
    " }

    " UndoTree {
        if isdirectory(expand("~/.vim/bundle/gundo.vim/"))
            nnoremap <Leader>u :GundoToggle<CR>
        endif
    " }

    " indent_guides {
        if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

    " Ag {
        let g:agprg = 'ag --nogroup --nocolor --column --smart-case'
        "let g:ag_highlight = 1
        nnoremap <Leader>ag :execute 'Ag ' .  expand('<cword>')<Cr>>)
        vnoremap <Leader>ag y:Ag -Q '<C-R>"'<CR>
    " }

    " startify {
        let g:startify_change_to_dir = 0
    " }
    
    " vdebug {
        let g:vdebug_options= {
            \    "port" : 9001,
            \    "server" : '192.168.98.10',
            \    "timeout" : 20,
            \    "on_close" : 'detach',
            \    "break_on_open" : 1,
            \    "ide_key" : '',
            \    "path_maps" : {"/usr/share/isis-dev": "/home/dev/isis"},
            \    "debug_window_level" : 0,
            \    "debug_file_level" : 0,
            \    "debug_file" : "",
            \    "watch_window_style" : 'expanded',
            \    "marker_default" : '⬦',
            \    "marker_closed_tree" : '▸',
            \    "marker_open_tree" : '▾'
            \}
    " }

    " ghcmod {
            " Haskell post write lint and check with ghcmod
            " $ `cabal install ghcmod` if missing and ensure
            " ~/.cabal/bin is in your $PATH.
            "if !executable("ghcmod")
                "autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            "endif
    " }

" }
