"#############################################################################
"###                               VIMTUNES                                ###
"#############################################################################

"=============================================================================
" VimTunes (Configuration)
"=============================================================================
let use0 = {} "priority 0 (hi)
let use1 = {} "priority 1
let use2 = {} "priority 2
let use9 = {} "priority 9 (low)

" setup
let use0["vim"]		= (1)
let use0["gvim"]	= (1) && has("gui_running")
let use0["macvim"]	= (1) && has("gui_macvim")
" editor keymaps and control
let use2["shortcut"]	= (1) && has("windows") "[sn][sN][sh][sj][sk][sl]
let use2["inputmap"]	= (1)
let use2["register"]	= (1) "[C-r]
let use2["number"]	= (1) "[sT]
let use2["tabstop"]	= (1) "[st]
let use2["listchars"]	= (1) "[sm]
let use2["textmode"]	= (1) "[sM]
let use2["textwrap"]	= (1) "[sw]
let use2["guioptions"]	= (1) && has("gui_running") "[sb]
" fileformat
let use2["linefeed"]	= (1) "[sV][sE]
let use2["multibyte"]	= (1) && has("multi_byte") "[sv][se]
let use2["fileinfo"]	= (0) && use2["linefeed"] && use2["multibyte"]
let use2["filetype"]	= (1)
" highlight
let use2["highlight"]	= (1) && has("syntax")
let use2["col80"]	= (1) && use2["highlight"]
let use2["col120"]	= (1) && use2["highlight"]
" modern-features
let use2["completion"]	= (1) "[C-d][C-n][C-p]
let use2["omnifunc"]	= (0) && use2["completion"]
let use2["folding"]	= (1) && has("folding")  "[sf]
let use2["quickfix"]	= (1) && has("quickfix") "[Tab]
let use2["netrw"]	= (1)
let use2["wordmove"]	= (1)
let use2["paramove"]	= (1) "[{][}]
let use2["vimgrep"]	= (1)
let use2["Cfile"]	= (1)
let use2["autoreopen"]	= (1)
" indicators
let use2["statusline"]	= (1) && has("statusline")
let use2["rulerline"]	= (1) && has("statusline")
let use2["tabline"]	= (1) && has("windows") "[,][.]
let use2["guitablabel"]	= (1) && has("windows") && has("gui_running")
" afterwork
let use9["registry"]	= (1)

"=============================================================================
" VimPlatform
"=============================================================================
" Setup $VIM_PLATFORM, the platform name what Vim running on.
if has("win64")
	" NOTE: has("win64") also has("win32")
	let $VIM_PLATFORM = "win64".   (has("gui")? "_gui" : "")
elseif has("win32")
	let $VIM_PLATFORM = "win".     (has("gui")? "_gui" : "")
elseif has("win32unix")
	let $VIM_PLATFORM = "cygwin".  (has("gui")? "_gui" : "")
elseif has("mac")
	let $VIM_PLATFORM = "mac".     (has("gui")? "_gui" : "")
elseif has("unix")
	let $VIM_PLATFORM = "unix".    (has("gui")? "_gui" : "")
else
	let $VIM_PLATFORM = "unknown". (has("gui")? "_gui" : "")
endif

" platform specific
if $VIM_PLATFORM ==# "win" || $VIM_PLATFORM ==# "win64"
	if has('persistent_undo')
		set noundofile
	endif
endif

"=============================================================================
" VimHostname
"=============================================================================
" Setup $HOSTNAME, the hostname name what Vim running on.
let $HOSTNAME = hostname()

" hostname specific
"if $HOSTNAME ==# "DOSHITA-PC"
"else
"endif

"#############################################################################
"###                            START TUNES                                ###
"#############################################################################

"=============================================================================
" VimTunes
"=============================================================================
let vimtunes = {}
function! vimtunes.tune(...) dict
	let self[a:1] = copy(a:2)
	for i in keys(self[a:1])
		let t = type(self[a:1][i])
		if (t == type(0) && self[a:1][i]) ||
		 \ (t != type(0))
			exec "call self.". i. "(self[a:1][i])"
		endif
	endfor
endfunction

"-----------------------------------------------------------------------------
" vim
"-----------------------------------------------------------------------------
function! vimtunes.vim(...) dict
	" jumplist (<C-o>,<C-p>)
	noremap <C-p> <C-i>
	" insert mode mappings
	imap <C-f> <right>
	imap <C-b> <left>
	imap <C-a> <Home>
	imap <C-e> <End>
	"imap <C-h> <Del>
	imap <C-c> <Esc>
endfunction

"-----------------------------------------------------------------------------
" gvim environment
"-----------------------------------------------------------------------------
function! vimtunes.gvim(...) dict
	set columns=90
	set lines=45
	set linespace=0
	set guioptions=e
	set guioptions-=m
	set guioptions-=T
	if has("gui_gtk2")
		"set guifont=Nimbas\ Mono\ L\ 8
		"set printfont=Nimbas\ Mono\ L\ 8
	elseif has("x11")
		set guifont=*-lucidatypewriter-medium-r-normal
		    \-*-*-180-*-*-m-*-*
		set printfont=*-lucidatypewriter-medium-r-normal
		    \-*-*-180-*-*-m-*-*
	elseif has("gui_win32")
		set guifont=ms_gothic:h16:cSHIFTJIS
		set printfont=ms_gothic:h16:cSHIFTJIS
	elseif has("gui_macvim")
		set guifont=Menlo:h24
		set printfont=Menlo:h24
		set fenc=
		set imdisable
		set transparency=5
		" fullscreen mode
		set fuoptions=maxvert,maxhorz
		autocmd GUIEnter * set fullscreen
	endif
	if has('kaoriya')
		highlight CursorIM guibg=White guifg=NONE
		set iminsert=0
		set imsearch=0
		" window-width workaround!
		autocmd VimEnter * :redraw
	endif
endfunction

"-----------------------------------------------------------------------------
" macvim environment
"-----------------------------------------------------------------------------
function! vimtunes.macvim(...) dict
	" remove macvim default configuration.
	let files = globpath('/Applications/MacVim*.app/Contents/Resources/vim/', '*vimrc')
	for filename in split(files, "\n")
		call self.rmrf(shellescape(filename))
		echo filename. " removed."
	endfor
endfunction

"-----------------------------------------------------------------------------
" shortcut
"-----------------------------------------------------------------------------
function! vimtunes.shortcut(...) dict
	"save & load
	"map <silent> sw <Esc>:w!<CR>
	"map          so <Esc>:o<Space>
	"map          sr <Esc>:r<Space>
	"map          sq <Esc>:q<CR>

	" repeat
	noremap s. .

	"split window
	map <silent> sn <Esc><C-W>S:call vimtunes.hresize(24)<CR>
	map <silent> sN <Esc><C-W><C-V>:call vimtunes.hresize(24)<CR>

	"move window
	map <silent> sj <Esc><C-W>j:call vimtunes.hresize(24)<CR>
	map <silent> sk <Esc><C-W>k:call vimtunes.hresize(24)<CR>
	map <silent> sh <Esc><C-W>h:call vimtunes.hresize(24)<CR>
	    \:call vimtunes.wresize(80)<CR>:<CR>
	map <silent> sl <Esc><C-W>l:call vimtunes.hresize(24)<CR>
	    \:call vimtunes.wresize(80)<CR>:<CR>
	map <silent> sJ <Esc><C-W>j:call vimtunes.hresize(100)<CR>
	map <silent> sK <Esc><C-W>k:call vimtunes.hresize(100)<CR>
	map <silent> sH <Esc><C-W>h:call vimtunes.hresize(100)<CR>
	map <silent> sL <Esc><C-W>l:call vimtunes.hresize(100)<CR>

	"resize window
	"map <silent> s; <Esc>z30<CR>
	map <silent> ss <Esc>:call vimtunes.hresize(100)<CR>
	    \:call vimtunes.wresize(200)<CR>:<CR>

	"jump window
	map <silent> s1 <Esc>1<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s2 <Esc>2<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s3 <Esc>3<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s4 <Esc>4<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s5 <Esc>5<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s6 <Esc>6<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s7 <Esc>7<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s8 <Esc>8<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s9 <Esc>9<C-W><C-W>:call vimtunes.hresize(24)<CR>
	map <silent> s0 <Esc>10<C-W><C-W>:call vimtunes.hresize(24)<CR>
endfunction

"-----------------------------------------------------------------------------
" inputmap
"-----------------------------------------------------------------------------
function! vimtunes.inputmap(...) dict
	imap <C-^>b     <S-Left>
	imap <C-^><C-b> <S-Left>
	imap <C-^>f     <S-Right>
	imap <C-^><C-f> <S-Right>
	"imap <C-^>w     <C-w>
	"imap <C-^><C-w> <C-w>
	"imap <C-^>d     <C-o>dw
	"imap <C-^><C-d> <C-o>dw

	cnoremap <C-a>  <C-b>
	cmap <C-f>      <Right>
	cmap <C-b>      <Left>
	cmap <C-^>b     <S-Left>
	cmap <C-^><C-b> <S-Left>
	cmap <C-^>f     <S-Right>
	cmap <C-^><C-f> <S-Right>
	"cmap <C-^>w     <C-w>
	"cmap <C-^><C-w> <C-w>
	"cmap <C-^>d     <C-o>dw
	"cmap <C-^><C-d> <C-o>dw
endfunction

"-----------------------------------------------------------------------------
" register
"-----------------------------------------------------------------------------
function! vimtunes.register(...) dict
	" register yank in Visual-mode
	" (reg<"> = reg<y> = reg<p>)
	vmap <C-r>" ""y
	vmap <C-r>a "ay
	vmap <C-r>b "by
	vmap <C-r>c "cy
	vmap <C-r>d "dy
	vmap <C-r>e "ey
	vmap <C-r>f "fy
	vmap <C-r>g "gy
	vmap <C-r>h "hy
	vmap <C-r>i "iy
	vmap <C-r>j "jy
	vmap <C-r>k "ky
	vmap <C-r>l "ly
	vmap <C-r>m "my
	vmap <C-r>n "ny
	vmap <C-r>o "oy
	vmap <C-r>p ""y
	"vmap <C-r>p "py
	vmap <C-r>q "qy
	vmap <C-r>r "ry
	vmap <C-r>s "sy
	vmap <C-r>t "ty
	vmap <C-r>u "uy
	vmap <C-r>v "vy
	vmap <C-r>w "wy
	vmap <C-r>x "xy
	vmap <C-r>y ""y
	"vmap <C-r>y "yy
	vmap <C-r>z "zy
	vmap <C-r>0 "0y
	vmap <C-r>1 "1y
	vmap <C-r>2 "2y
	vmap <C-r>3 "3y
	vmap <C-r>4 "4y
	vmap <C-r>5 "5y
	vmap <C-r>6 "6y
	vmap <C-r>7 "7y
	vmap <C-r>8 "8y
	vmap <C-r>9 "9y

	" register paste in Insert-mode
	" (reg<"> = reg<y> = reg<p>)
	inoremap <C-r>y <C-r>"
	inoremap <C-r>p <C-r>"

	" register paste in Command-mode
	" (reg<"> = reg<y> = reg<p>)
	cnoremap <C-r>y <C-r>"
	cnoremap <C-r>p <C-r>"
endfunction

"-----------------------------------------------------------------------------
" number
"-----------------------------------------------------------------------------
function! vimtunes.number(...) dict
	" keymap
	map sr <Esc>:call vimtunes.change_number()<CR>
	" objects
	let mat = {
	    \ 0 : 1,
	    \ 1 : 0,
	    \ }
	let self.show_number =
	    \ g:CONFIGMATRIX.new("w:show_number", "&nu", "0", mat)
endfunction

function! vimtunes.change_number(...) dict
	let num = self.show_number.rotate()
	let cmd = (num)? "number" : "nonumber"
	exec "set ". cmd
endfunction

"-----------------------------------------------------------------------------
" tabstop
"-----------------------------------------------------------------------------
function! vimtunes.tabstop(...) dict
	" keymap
	map st <Esc>:call vimtunes.change_tabstop()<CR>
	" objects
	let mat = {
	    \ 8 : 4,
	    \ 4 : 2,
	    \ 2 : 8,
	    \ }
	let self.show_tabstop =
	    \ g:CONFIGMATRIX.new("w:show_tabstop", "&tabstop", "8", mat)
endfunction

function! vimtunes.change_tabstop(...) dict
	let num = self.show_tabstop.rotate()
	exec "set tabstop=". num
	exec "set shiftwidth=". num
endfunction

"-----------------------------------------------------------------------------
" listchars
"-----------------------------------------------------------------------------
function! vimtunes.listchars(...) dict
	" keymap
	map sT <Esc>:call vimtunes.change_listchars()<CR>
	" objects
	let mat = {
	    \ 0 : 1,
	    \ 1 : 2,
	    \ 2 : 0,
	    \ }
	let self.show_listchars =
	    \ g:CONFIGMATRIX.new("w:show_listchars", "0", "0", mat)
	" initialize
	call self.change_listchars(0)
endfunction

function! vimtunes.change_listchars(...) dict
	if exists("a:2")
		let num = a:2
	elseif exists("a:1")
		if a:1 < 0
			let num = self.show_listchars.current()
		else
			let num = self.show_listchars.current(a:1)
		endif
	else
		let num = self.show_listchars.rotate()
	endif
	" set
	if num == 0
		set listchars=eol:\ ,tab:\.\ ,extends:<,trail:\_
		call self.change_highlight('SpecialKey', 'SpecialKeyRed')
	elseif num == 1
		set listchars=eol:\ ,tab:\ \ ,extends:<,trail:\
		call self.change_highlight('SpecialKey', 'SpecialKeyRed')
	elseif num == 2
		set listchars=eol:\ ,tab:\>\-,extends:<,trail:\_
		call self.change_highlight('SpecialKey', 'SpecialKeyBlue')
	elseif num == 3 " insertmode
		set listchars=eol:\~,tab:\.\ ,extends:<,trail:\_
	endif
endfunction

"-----------------------------------------------------------------------------
" textmode
"-----------------------------------------------------------------------------
function! vimtunes.textmode(...) dict
	" keymap
	map sM <Esc>:call vimtunes.change_textmode()<CR>
	" objects
	let mat = {
	    \ 1 : 0,
	    \ 0 : 1,
	    \ }
	let self.show_textmode =
	    \ g:CONFIGMATRIX.new("w:show_textmode", "&textmode", "0", mat)
endfunction

function! vimtunes.change_textmode(...) dict
	let num = self.show_textmode.rotate()
	let cmd = (num)?
	    \ "set textmode | echo 'textmode(win32)'" :
	    \ "set notextmode | echo 'notextmode(unix)'"
	exec cmd
endfunction

"-----------------------------------------------------------------------------
" wrap
"-----------------------------------------------------------------------------
function! vimtunes.textwrap(...) dict
	" keymap
	map sw <Esc>:call vimtunes.change_textwrap()<CR>
	" objects
	let mat = {
	    \ 1 : 0,
	    \ 0 : 1,
	    \ }
	let self.show_textwrap =
	    \ g:CONFIGMATRIX.new("w:show_textwrap", "&wrap", "0", mat)
endfunction

function! vimtunes.change_textwrap(...) dict
	let num = self.show_textwrap.rotate()
	let cmd = (num)?
	    \ "set wrap | echo 'wrap'" :
	    \ "set nowrap | echo 'nowrap'"
	exec cmd
endfunction

"-----------------------------------------------------------------------------
" guioptions
"-----------------------------------------------------------------------------
function! vimtunes.guioptions(...) dict
	" keymap
	map sb <Esc>:call vimtunes.change_guioptions()<CR>
	" objects
	let mat = {
	    \ 'em' : 'e',
	    \ 'e'  : 'em',
	    \ }
	let self.show_guioptions =
	    \ g:CONFIGMATRIX.new("w:show_guioptions","&guioptions","'e'",mat)
endfunction

function! vimtunes.change_guioptions(...) dict
	let num = self.show_guioptions.rotate()
	let cmd = 'set guioptions='. num
	exec cmd | echo cmd
endfunction

"-----------------------------------------------------------------------------
" linefeed
"-----------------------------------------------------------------------------
function! vimtunes.linefeed(...) dict
	" default
	if has("win32")
		set fileformat=dos
		set fileformats=dos,unix,mac
	else
		set fileformat=unix
		set fileformats=unix,mac,dos
	endif
	" keymap
	map sE <Esc>:call vimtunes.change_file_linefeed()<CR>
	map sV <Esc>:call vimtunes.change_view_linefeed()<CR>
	" objects
	let mat = {
	    \ 'dos'  : 'unix',
	    \ 'unix' : 'mac',
	    \ 'mac'  : 'dos',
	    \ }
	let self.file_linefeed =
	    \ g:CONFIGMATRIX.new("b:file_linefeed", "&ff", "&ff", mat)
	let self.view_linefeed =
	    \ g:CONFIGMATRIX.new("b:view_linefeed", "&ff", "&ff", mat)
endfunction

function! vimtunes.change_file_linefeed(...) dict
	if exists("a:1")
		let linefeed = self.file_linefeed.current(a:1)
	else
		let linefeed = self.file_linefeed.rotate()
	endif
	exec "set ff=". linefeed
	call self.display_fileinfo()
endfunction

function! vimtunes.change_view_linefeed(...) dict
	" fileformat
	let linefeed = self.view_linefeed.rotate()
	let fileformat = " ++ff=". linefeed
	" sync file-linefeed with view-linefeed
	call self.file_linefeed.current(linefeed)
	" fileencoding
	let fileencoding = ""
	if self.use2["multibyte"]
		let encoding = self.get_view_encoding()
		let fileencoding = " ++enc=". encoding
	endif
	exec ":edit!". fileformat. fileencoding
	call self.display_fileinfo()
endfunction

function! vimtunes.get_file_linefeed(...) dict
	return self.file_linefeed.current()
endfunction

function! vimtunes.get_view_linefeed(...) dict
	return self.view_linefeed.current()
endfunction

"-----------------------------------------------------------------------------
" multibyte
"-----------------------------------------------------------------------------
function! vimtunes.multibyte(...) dict
	" keyboard/display encoding
	if has("win32")
		set termencoding=cp932
		set encoding=cp932
	else
		"system default
	endif
	" file read&write encoding
	set fileencoding=japan
	set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp,utf-16
	" keymap
	map se <Esc>:call vimtunes.change_file_encoding()<CR>
	map sv <Esc>:call vimtunes.change_view_encoding()<CR>
	" objects
	let mat = {
	    \ 'utf-8'       : 'euc-jp',
	    \ 'euc-jp'      : 'cp932',
	    \ 'cp932'       : 'iso-2022-jp',
	    \ 'iso-2022-jp' : 'utf-16',
	    \ 'utf-16'      : 'utf-8',
	    \ }
	let self.file_encoding =
	    \ g:CONFIGMATRIX.new("b:file_encoding", "&fenc", "&fenc", mat)
	let self.view_encoding =
	    \ g:CONFIGMATRIX.new("b:view_encoding", "&fenc", "&fenc", mat)
endfunction

function! vimtunes.change_file_encoding(...) dict
	if exists("a:1")
		let encoding = self.file_encoding.current(a:1)
	else
		let encoding = self.file_encoding.rotate()
	endif
	exec "set fenc=". encoding
	call self.display_fileinfo()
endfunction

function! vimtunes.change_view_encoding(...) dict
	" fileencoding
	let encoding = self.view_encoding.rotate()
	let fileencoding = " ++enc=". encoding
	" sync file-encoding with view-encoding
	call self.change_file_encoding(encoding)
	" fileforma
	let linefeed = self.get_view_linefeed()
	let fileformat = " ++ff=". linefeed
	exec ":edit!". fileformat. fileencoding
	call self.display_fileinfo()
endfunction

function! vimtunes.get_file_encoding(...) dict
	return self.file_encoding.current()
endfunction

function! vimtunes.get_view_encoding(...) dict
	return self.view_encoding.current()
endfunction

"-----------------------------------------------------------------------------
" display_fileinfo
"-----------------------------------------------------------------------------
function! vimtunes.fileinfo(...) dict
	nmap <silent> sd <C-l><Esc>:call vimtunes.display_fileinfo()<CR>
	autocmd BufEnter * :call vimtunes.display_fileinfo()
endfunction

function! vimtunes.display_fileinfo(...) dict
	let msg = ""
	if exists("a:1")
		let msg = " ". a:1
	endif
	let view_enc = self.get_view_encoding()
	let view_lf  = self.get_view_linefeed()
	let save_enc = self.get_file_encoding()
	let save_lf  = self.get_file_linefeed()
	if view_enc == save_enc
		let save_enc=""
	endif
	if view_lf == save_lf
		let save_lf=""
	endif
	redraw
	echo '"'. bufname("%"). '" [d] '. line('$'). 'L '.
	    \ "[v]". view_enc. ",". view_lf. " ".
	    \ "=>[e]". save_enc. ",". save_lf
endfunction

"-----------------------------------------------------------------------------
" filetype
"-----------------------------------------------------------------------------
function! vimtunes.filetype(...) dict
	autocmd FileType snippets :call vimtunes.filetype_snippets() "snipMate snippets

	autocmd FileType c        :call vimtunes.filetype_c()    " C
	autocmd FileType cpp      :call vimtunes.filetype_cpp()  " C++
	autocmd FileType cs       :call vimtunes.filetype_cs()   " C#
	autocmd FileType go       :call vimtunes.filetype_go()   " GO
	autocmd FileType m        :call vimtunes.filetype_objc() " Objective-C (C)
	autocmd FileType mm       :call vimtunes.filetype_objc() " Objective-C (C++)
	autocmd FileType java     :call vimtunes.filetype_java() " Java

	autocmd FileType rb       :call vimtunes.filetype_rb()   " Ruby
	autocmd FileType rake     :call vimtunes.filetype_rake() " Rakefile (.rake)
	autocmd FileType erb      :call vimtunes.filetype_html() " eRuby
	autocmd FileType yaml     :call vimtunes.filetype_yaml() " Yaml
	autocmd FileType py       :call vimtunes.filetype_py()   " Python

	autocmd FileType php      :call vimtunes.filetype_php()  " PHP
	autocmd FileType sql      :call vimtunes.filetype_sql()  " SQL
	autocmd FileType xml      :call vimtunes.filetype_xml()  " XML
	autocmd FileType html     :call vimtunes.filetype_html() " HTML
	autocmd FileType xhtml    :call vimtunes.filetype_html() " XHTML

	autocmd FileType js       :call vimtunes.filetype_js()   " JavaScript
	autocmd FileType json     :call vimtunes.filetype_json() " JSON
	autocmd FileType jake     :call vimtunes.filetype_jake() " Jakefile
	autocmd FileType ejs      :call vimtunes.filetype_html() " eJS
	autocmd FileType jade     :call vimtunes.filetype_jade() " Jade
	autocmd FileType css      :call vimtunes.filetype_css()  " CSS
	autocmd FileType styl     :call vimtunes.filetype_styl() " Stylus

	" ?
	"autocmd FileType Rakefile :call vimtunes.filetype_rake() " Rakefile
	"autocmd FileType Jakefile :call vimtunes.filetype_jake() " Jakefile

	" BACKUP
	"autocmd BufEnter *.snippets :call vimtunes.filetype_snippets() "snipMate snippets
	"autocmd BufEnter *.c      :call vimtunes.filetype_c()    " C
	"autocmd BufEnter *.cpp    :call vimtunes.filetype_cpp()  " C++
	"autocmd BufEnter *.cs     :call vimtunes.filetype_cs()   " C#
	"autocmd BufEnter *.m      :call vimtunes.filetype_objc() " Objective-C
	"autocmd BufEnter *.mm     :call vimtunes.filetype_objc() " Objective-C (C++)
	"autocmd BufEnter *.java   :call vimtunes.filetype_java() " Java
	"autocmd BufEnter *.rb     :call vimtunes.filetype_rb()   " Ruby
	"autocmd BufEnter Rakefile :call vimtunes.filetype_rake() " Rakefile
	"autocmd BufEnter *.rake   :call vimtunes.filetype_rake() " Rakefile (.rake)
	"autocmd BufEnter *.erb    :call vimtunes.filetype_html() " eRuby
	"autocmd BufEnter *.yaml   :call vimtunes.filetype_yaml() " Yaml
	"autocmd BufEnter *.py     :call vimtunes.filetype_py()   " Python
	"autocmd BufEnter *.php    :call vimtunes.filetype_php()  " PHP
	"autocmd BufEnter *.sql    :call vimtunes.filetype_sql()  " SQL
	"autocmd BufEnter *.xml    :call vimtunes.filetype_xml()  " XML
	"autocmd BufEnter *.html   :call vimtunes.filetype_html() " HTML
	"autocmd BufEnter *.xhtml  :call vimtunes.filetype_html() " XHTML
	"autocmd BufEnter *.js     :call vimtunes.filetype_js()   " JavaScript
	"autocmd BufEnter *.json   :call vimtunes.filetype_json() " JSON
	"autocmd BufEnter Jakefile :call vimtunes.filetype_jake() " Jakefile
	"autocmd BufEnter *.ejs    :call vimtunes.filetype_html() " eJS
	"autocmd BufEnter *.jade   :call vimtunes.filetype_jade() " Jade
	"autocmd BufEnter *.css    :call vimtunes.filetype_css()  " CSS
	"autocmd BufEnter *.styl   :call vimtunes.filetype_styl() " Stylus
endfunction

function! vimtunes.filetype_snippets(...) dict
	"if !self.set_filetype_name_to_bufvar("snippets")
	"	return
	"endif
	setlocal foldmethod=marker
endfunction

function! vimtunes.filetype_c(...) dict
	"if !self.set_filetype_name_to_bufvar("c")
	"	return
	"endif
	setlocal tabstop=8
	setlocal shiftwidth=8
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	"call self.col80_enable()
endfunction

function! vimtunes.filetype_cpp(...) dict
	"if !self.set_filetype_name_to_bufvar("cpp")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	"call self.col120_enable()
endfunction

function! vimtunes.filetype_cs(...) dict
	"if !self.set_filetype_name_to_bufvar("cs")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	setlocal foldmethod=syntax
	call self.close_folding()
	"call self.col120_enable()
endfunction

function! vimtunes.filetype_go(...) dict
	"if !self.set_filetype_name_to_bufvar("go")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	"setlocal foldmethod=syntax
	"call self.close_folding()
	"call self.col120_enable()
endfunction

function! vimtunes.filetype_objc(...) dict
	"if !self.set_filetype_name_to_bufvar("objc")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	"call self.col120_enable()
endfunction

function! vimtunes.filetype_java(...) dict
	"if !self.set_filetype_name_to_bufvar("java")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_rb(...) dict
	"if !self.set_filetype_name_to_bufvar("rb")
	"	return
	"endif
	setlocal tabstop=2
	setlocal shiftwidth=2
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_rake(...) dict
	"if !self.set_wrapper_filetype_name_to_bufvar("rake")
	"	return
	"endif
	call self.filetype_rb()
endfunction

function! vimtunes.filetype_yaml(...) dict
	"if !self.set_filetype_name_to_bufvar("yaml")
	"	return
	"endif
	setlocal tabstop=2
	setlocal shiftwidth=2
	setlocal expandtab
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_py(...) dict
	"if !self.set_filetype_name_to_bufvar("py")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal noexpandtab
	setlocal autoindent
	setlocal smartindent
	call self.change_listchars(2)
endfunction

function! vimtunes.filetype_php(...) dict
	"if !self.set_filetype_name_to_bufvar("php")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
	call self.col120_enable()
endfunction

function! vimtunes.filetype_sql(...) dict
	"if !self.set_filetype_name_to_bufvar("sql")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal expandtab
endfunction

function! vimtunes.filetype_xml(...) dict
	"if !self.set_filetype_name_to_bufvar("xml")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
endfunction

function! vimtunes.filetype_html(...) dict
	"if !self.set_filetype_name_to_bufvar("html")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_js(...) dict
	"if !self.set_filetype_name_to_bufvar("js")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_json(...) dict
	"if !self.set_filetype_name_to_bufvar("json")
	"	return
	"endif
	setlocal tabstop=2
	setlocal shiftwidth=2
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_jake(...) dict
	"if !self.set_wrapper_filetype_name_to_bufvar("jake")
	"	return
	"endif
	setlocal ft=javascript
	call self.filetype_js()
endfunction

function! vimtunes.filetype_jade(...) dict
	"if !self.set_filetype_name_to_bufvar("jade")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_css(...) dict
	"if !self.set_filetype_name_to_bufvar("css")
	"	return
	"endif
	setlocal tabstop=4
	setlocal shiftwidth=4
	call self.autoexpandtab()
	setlocal autoindent
	setlocal smartindent
endfunction

function! vimtunes.filetype_styl(...) dict
	"if !self.set_wrapper_filetype_name_to_bufvar("styl")
	"	return
	"endif
	setlocal ft=css
	call self.filetype_css()
endfunction

" check and set filetype string to buffer variable.
"function! vimtunes.set_filetype_name_to_bufvar(ft)
"	if exists("b:ft") && b:ft == a:ft
"		return 0
"	endif
"	let b:ft = a:ft
"	return 1
"endfunction

" check and set wrapper filetype string to buffer variable.
"function! vimtunes.set_wrapper_filetype_name_to_bufvar(ft)
"	if exists("b:wft") && b:wft == a:ft
"		return 0
"	endif
"	let b:wft = a:ft
"	return 1
"endfunction

" detect indent and set expadtab or noexpandtab automatically.
function! vimtunes.autoexpandtab()
	if search("^\t") > 0
		setlocal noexpandtab
	else
		setlocal expandtab
	endif
endfunction

"-----------------------------------------------------------------------------
" highlight
"-----------------------------------------------------------------------------
function! vimtunes.highlight(...) dict
	syntax enable "should this be here?
	if has("gui_running")
		let self.highlighter = g:HIGHLIGHT_GUI.new()
		let g:hi_color = "horror"
	else
		let self.highlighter = g:HIGHLIGHT_CTERM.new()
		let g:hi_color = "toybox16"
	endif
	if has("gui_macvim")
		" XXX macvim workaround!!
		autocmd VimEnter
		   \ *
		   \ :call vimtunes.highlighter.hi(g:hi_color)
	else
		call self.highlighter.hi(g:hi_color)
	endif
endfunction

function! vimtunes.change_highlight(name, name_to_change) dict
	let syn = self.highlighter.syntax[a:name_to_change]
	let self.highlighter.syntax[a:name] = syn
	call self.highlighter.hi(g:hi_color)
endfunction

"-----------------------------------------------------------------------------
" col80
"-----------------------------------------------------------------------------
function! vimtunes.col80(...) dict
	let self.use_col80 = 1
endfunction

function! vimtunes.col80_enable(...) dict
	if self.use_col80
		match none
		match OverCol /\%>80v./
	endif
endfunction

"-----------------------------------------------------------------------------
" col120
"-----------------------------------------------------------------------------
function! vimtunes.col120(...) dict
	let self.use_col120 = 1
endfunction

function! vimtunes.col120_enable(...) dict
	if self.use_col120
		match none
		match OverCol /\%>120v./
	endif
endfunction

"-----------------------------------------------------------------------------
" completion
"-----------------------------------------------------------------------------
function! vimtunes.completion(...) dict
	" when press <C-n> or <C-p> at first, do not insert
	autocmd InsertEnter,CursorMovedI * call vimtunes.compsel_reset()
	"inoremap <C-d> <C-R>=vimtunes.compsel_next(1)<CR>
	"inoremap <C-u> <C-R>=vimtunes.compsel_prev(1)<CR>
	inoremap <C-n> <C-R>=vimtunes.compsel_next(1)<CR>
	inoremap <C-p> <C-R>=vimtunes.compsel_prev(0)<CR>

	" menu mode (setting is depended by.script)
	"  menu, menuone -> we need for detect complete-mode.
	"  no 'preview'  -> prevent re-pop complete menu.
	"  no 'longest'  -> bug?
	set completeopt=menu,menuone
endfunction

" completion functions
function! vimtunes.compsel_reset() dict
	" while pop-up menu is visible, do not reset.
	let b:compsel = (pumvisible() == 0)? 0 : 1
	return
endfunction
function! vimtunes.compsel_next(n) dict
	let key = (b:compsel || a:n)? "\<C-n>" : "\<C-n>\<C-p>"
	let b:compsel = 1
	return key
endfunction
function! vimtunes.compsel_prev(n) dict
	let key = (b:compsel || a:n)? "\<C-p>" : "\<C-p>\<C-n>"
	let b:compsel = 1
	return key
endfunction


"-----------------------------------------------------------------------------
" omni-completion (OBOSOLETED)
"-----------------------------------------------------------------------------
function! vimtunes.omnifunc(...) dict
	" file-type
	"  need latest ctags for omni completion.
	"  see http://ctags.sourceforge.net/
	autocmd FileType c
	    \ set omnifunc=ccomplete#Complete
	    \ | call vimtunes.c_omnienv()
	autocmd FileType php
	    \ set omnifunc=phpcomplete#CompletePHP
	    \ | call vimtunes.c_omnienv()
	autocmd FileType xml
	    \ set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType html
	    \ set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css
	    \ set omnifunc=csscomplete#CompleteCSS
	autocmd FileType python
	    \ set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript
	    \ set omnifunc=javascriptcomplete#CompleteJS
endfunc

" omni-environment
function! vimtunes.c_omnienv()
	inoremap <expr> . vimtunes.omni_pointer()
	inoremap <expr> -> vimtunes.omni_refer()
endfunc
function! vimtunes.omni_pointer()
	"call my:settag()
	let key = (b:compsel)? ".\<C-X>\<C-O>" : ".\<C-X>\<C-O>\<C-p>"
	let b:compsel = 1
	return key
endfunc
function! vimtunes.omni_refer()
	"call my:settag()
	let key = (b:compsel)? "->\<C-X>\<C-O>" : "->\<C-X>\<C-O>\<C-p>"
	let b:compsel = 1
	return key
endfunc

"-----------------------------------------------------------------------------
" folding
"-----------------------------------------------------------------------------
function! vimtunes.folding(...) dict
	" init
	set foldmethod=marker
	call self.close_folding()
	set fillchars="vert:|,fold: "
	set foldtext=vimtunes.foldtext()
	"autocmd BufEnter * call vimtunes.open_folding()
	" keymap
	map sf <Esc>:call vimtunes.change_folding()<CR>
	" objects
	let mat = {
	    \  'manual' : 'manual',
	    \  'indent' : 'syntax',
	    \  'syntax' : 'marker',
	    \  'marker' : 'indent',
	    \ }
	let self.show_folding = g:CONFIGMATRIX.new("w:show_folding",
	    \ "&foldmethod", "'manual'", mat)
endfunction

" fold text
function! vimtunes.foldtext()
	let sub   = getline(v:foldstart)
	let nline = v:foldend - v:foldstart
	" caption の種類
	let prefix   = '(+'. nline. ') ['
	let postfix  = ']'
	let righting = 1
	if match(sub, "region") > 0 " C# region
		let prefix   = '(+'. nline. ') ['
		let postfix  = ']'
		let righting = 0
	endif
	" 先頭の空白を取得
	let idx = match(sub, '\S')
	let spc = strpart(sub, 0, idx)
	let sub = strpart(sub, idx)
	" caption の作成
	let sub = substitute(sub, '/\*\|\*/',  '', 'g')
	let sub = substitute(sub, '{'.'{'.'{', '', 'g')
	let sub = substitute(sub, '#region ',  '', 'g')
	" caption 長の計算
	let space   = ''
	if righting
		if len(sub) > 30
			let sub = strpart(sub, 0, 27). "..."
		endif
		let caption = prefix. sub. postfix
		let mlen    = len(caption)
		let sublen  = len(substitute(caption, ".", "x", "g"))
		let nmulti  = 0
		if mlen != sublen
			" マルチバイト文字数を求めてサイズ調整する
			" sublen は文字数, mlen はバイト数
			" マルチバイト文字は 3 バイト固定で計算する
			" ... たまにずれる (が許容した) ことに注意
			let nmulti = (mlen - sublen) / 2
		end
		" 右寄せを行う
		let columns = winwidth(0)
		for i in range(columns - sublen - nmulti)
			let space = space. ' '
		endfor
	else
		let caption = prefix. sub. postfix
		let space   = spc
	endif
	return space. caption
endfunction

" open/close
function! vimtunes.open_folding()
	exec "normal \<Esc>zR"
endfunction
function! vimtunes.close_folding()
	exec "normal \<Esc>zM"
endfunction

" change foldmethod
function! vimtunes.change_folding()
	let num = self.show_folding.rotate()
	let cmd = "set foldmethod=". num
	exec cmd | echo ""
	if num == 'marker'
		call self.close_folding()
	else
		call self.open_folding()
	endif
	echo cmd
endfunction

"-----------------------------------------------------------------------------
" quickfix
"-----------------------------------------------------------------------------
function! vimtunes.quickfix(...) dict
	let self.qf_use = {}
	let self.qf_use.quick_resume = 1
	" keymap
	nmap <silent> <Tab> <Esc>:call vimtunes.qf_toggle()<CR>
endfunction
function! vimtunes.quickfix_map() dict
	" TODO fix this later
	nmap <silent> <expr> <C-n> vimtunes.qf_next()
	nmap <silent> <expr> <C-p> vimtunes.qf_prev()
endfunction
function! vimtunes.quickfix_unmap() dict
	" TODO fix this later
	nunmap <C-n>
	nmap <silent> <C-p> :call CtrlPCall()<CR>
endfunction

"quickfix functions
function! vimtunes.qf_exists()
	let tablist = tabpagebuflist(tabpagenr())
	for i in tablist
		if getbufvar(i, "&buftype") == "quickfix"
			return i
		endif
	endfor
	return 0
endfunction
" next/prev
function! vimtunes.qf_next()
	return (self.qf_exists())?
	    \ "\<Esc>:cnext\<CR>" :
	    \ "\<Esc>:tab split\<CR>"
endfunction
function! vimtunes.qf_prev()
	return (self.qf_exists())?
	    \ "\<Esc>:cprev\<CR>" :
	    \ "\<C-p>"
endfunction
" open/close
function! vimtunes.qf_mark(resume)
	if self.qf_use.quick_resume
		let mark = nr2char(char2nr("Z") - tabpagenr())
		if a:resume
			exec "normal \<Esc>'". mark
		else
			exec "normal \<Esc>m". mark
		endif
	endif
endfunction
function! vimtunes.qf_open()
	if !self.qf_exists()
		call self.qf_mark(0)
		let w = winnr()
		exec ":copen"
		exec "normal \<Esc>". w. "\<C-W>\<C-W>"
	endif
	if len(getqflist()) > 0
		exec ":cc"
	endif
	redraw | echo "[TAB] close quickfix"
	call self.quickfix_map()
endfunction
function! vimtunes.qf_close()
	if self.qf_exists()
		exec ":cclose"
		call self.qf_mark(1)
	endif
	redraw | echo "quickfix closed."
	call self.quickfix_unmap()
endfunction
function! vimtunes.qf_toggle()
	return (self.qf_exists())? self.qf_close() : self.qf_open()
endfunction

"-----------------------------------------------------------------------------
" netrw
"-----------------------------------------------------------------------------
function! vimtunes.netrw(...) dict
	let g:netrw_liststyle = 3
	let g:netrw_browse_split = 1
	let g:netrw_alto = 1
	let g:netrw_altv = 1
	let g:netrw_winsize = 100
endfunction

"-----------------------------------------------------------------------------
" wordmove
"-----------------------------------------------------------------------------
function! vimtunes.wordmove(...) dict
	" char maps
	let s:na = char2nr('a')
	let s:nz = char2nr('z')
	let s:nA = char2nr('A')
	let s:nZ = char2nr('Z')
	let s:n0 = char2nr('0')
	let s:n9 = char2nr('9')
	let s:sp = char2nr(' ')
	let s:tb = char2nr("\t")
	" move maps    _  &  a  A  9  eol / -> st v new_st
	let s:fmap = [[1, 0, 0, 0, 0, 0],
	  \           [1, 1, 0, 0, 0, 0],
	  \           [1, 0, 1, 0, 0, 0],
	  \           [1, 0, 1, 1, 1, 0],
	  \           [0, 0, 0, 0, 1, 0],
	  \           [0, 0, 0, 0, 0, 0]]
	let s:bmap = [[1, 1, 1, 1, 1, 0],
	  \           [0, 1, 1, 1, 1, 0],
	  \           [0, 0, 1, 1, 0, 0],
	  \           [0, 0, 0, 1, 0, 0],
	  \           [0, 0, 0, 0, 1, 0],
	  \           [0, 0, 0, 0, 0, 0]]
	"let s:dmap = [[1, 0, 0, 0, 0, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 0, 0, 0, 0, 1]]
	"let s:umap = [[1, 0, 0, 0, 0, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 1, 1, 1, 1, 0],
	"  \           [0, 0, 0, 0, 0, 1]]
	" keymaps
	map <expr> W  vimtunes.wordmove_forward()
	map <expr> B  vimtunes.wordmove_backward()
	"map <expr> s] vimtunes.wordmove_down()
	"map <expr> s[ vimtunes.wordmove_up()
endfunction

function! vimtunes.wordmove_forward() dict
	let cursor = getpos('.')
	let line   = getline('.')
	let col    = cursor[2]
	let st     = self.wordmove_state(line, col)
	let len    = len(line)
	let cnt    = 0
	let loop   = 1
	while loop && col <= len
		let cnt    = cnt + 1
		let col    = col + 1
		let new_st = self.wordmove_state(line, col)
		let loop   = s:fmap[st][new_st]
		let st     = new_st
	endwhile
	return cnt. "l"
endfunction

function! vimtunes.wordmove_backward() dict
	let cursor = getpos('.')
	let line   = getline('.')
	let col    = cursor[2] - 1
	let st     = self.wordmove_state(line, col)
	let cnt    = 1
	let loop   = 1
	while loop && col >= 0
		let col    = col - 1
		let new_st = self.wordmove_state(line, col)
		let loop   = s:bmap[st][new_st]
		if loop == 0
			break
		end
		let cnt = cnt + 1
		let st  = new_st
	endwhile
	return cnt. "h"
endfunction

"function! vimtunes.wordmove_down() dict
"	let cursor = getpos('.')
"	let lnum   = cursor[1]
"	let col    = cursor[2]
"	let lines  = getline(lnum, lnum + 30)
"	let line   = lines[0]
"	let st     = self.wordmove_state(line, col)
"	let cnt    = 0
"	let loop   = 1
"	while loop && cnt < (len(lines) - 1)
"		let line   = lines[cnt + 1]
"		let new_st = self.wordmove_state(line, col)
"		let loop   = s:dmap[st][new_st]
"		if loop
"			let cnt = cnt + 1
"			let st  = new_st
"		endif
"	endwhile
"	if cnt > 0
"		return cnt. "j"
"	endif
"	return "j"
"endfunction

"function! vimtunes.wordmove_up() dict
"	let cursor = getpos('.')
"	let lnum   = cursor[1]
"	let col    = cursor[2]
"	let snum   = lnum - 30
"	if snum < 1
"		let snum = 1
"	endif
"	let lines  = reverse(getline(snum, lnum))
"	let line   = lines[0]
"	let st     = self.wordmove_state(line, col)
"	let cnt    = 0
"	let loop   = 1
"	while loop && cnt < (len(lines) - 1)
"		let line   = lines[cnt + 1]
"		let new_st = self.wordmove_state(line, col)
"		let loop   = s:dmap[st][new_st]
"		if loop
"			let cnt = cnt + 1
"			let st  = new_st
"		endif
"	endwhile
"	if cnt > 0
"		return cnt. "k"
"	endif
"	return "k"
"endfunction

function! vimtunes.wordmove_state(line, col) dict
	if a:col > len(a:line)
		return 5 "end-of-line
	endif
	let nc = char2nr(a:line[a:col - 1])
	if nc >= s:na && nc <= s:nz
		return 2 "lower-scale
	elseif nc >= s:nA && nc <= s:nZ
		return 3 "upper-scale
	elseif nc >= s:n0 && nc <= s:n9
		return 4 "number
	elseif nc == s:sp || nc == s:tb
		return 0 "brank
	endif
	return 1 "other
endfunction

"-----------------------------------------------------------------------------
" paramove
"-----------------------------------------------------------------------------
function! vimtunes.paramove(...) dict
	" NOTE:
	" Recognize both 'empty line' and 'blank line' correctly
	" when moving paragraph ('empty line' only until now,
	" but *role of 'blank line' is same as 'empty line'*.
	" Therefore, there is no bad effect to recognize both).
	" No need to keep the old version paragraph moving.
	" Overwrite it and completely swith to new version.
	nmap <expr> } vimtunes.do_paramove(1)
	nmap <expr> { vimtunes.do_paramove(-1)
	vmap <expr> } vimtunes.do_paramove(1)
	vmap <expr> { vimtunes.do_paramove(-1)
endfunction

function! vimtunes.do_paramove(direction) dict
	let p = "^[\t ]\*$"
	let x = "[^\t ]"
	let n = line(".")
	let m = line("$")
	let h = n
	let t = n
	let d = 20
	while n >= 1 && n <= m
		let r = (a:direction > 0)? t - n : n - h
		if r <= 0
			if a:direction > 0
				let h = n
				let t = n + d
				let t = (t > m)? m : t
			else
				let h = n - d
				let t = n
				let h = (h < 1)? 1 : h
			endif
			let l = getline(h, t)
		endif
		let v = n - h
		if match(l[v], p) < 0
			break
		endif
		let n = n + a:direction
	endwhile
	while n >= 1 && n <= m
		let r = (a:direction > 0)? t - n : n - h
		if r <= 0
			if a:direction > 0
				let h = n
				let t = n + d
				let t = (t > m)? m : t
			else
				let h = n - d
				let t = n
				let h = (h < 1)? 1 : h
			endif
			let l = getline(h, t)
		endif
		let v = n - h
		if match(l[v], x) < 0
			break
		endif
		let n = n + a:direction
	endwhile
	return n. "gg"
endfunction

"BACKUP
"nnoremap  s] }
"nnoremap  s[ {
"vnoremap  s] }
"vnoremap  s[ {
"nmap <expr> s] vimtunes.do_paramove(0)
"nmap <expr> s[ vimtunes.do_paramove(1)
"vmap <expr> s] vimtunes.do_paramove(0)
"vmap <expr> s[ vimtunes.do_paramove(1)

"-----------------------------------------------------------------------------
" vimgrep
"-----------------------------------------------------------------------------
function! vimtunes.vimgrep(...) dict
	" keymaps
	"map ? :VimGrep ./**/*.<c-r>=&ft<CR> <c-r>=expand("<cword>")<cr>
	map ? :VimGrep ./**/* <c-r>=expand("<cword>")<cr>

	" VimGrep
	command! -nargs=* -complete=file VimGrep
	    \ :call vimtunes.VimGrepCommand(<f-args>)
endfunction

function! vimtunes.VimGrepCommand(...) dict
	let mesg = "VimGrep: File: "
	let file = (!exists("a:1"))? inputdialog(mesg, "**/*", "") : a:1
	if file == ""
		echo "VimGrep: cancelled."
		return
	endif

	let mesg = "VimGrep: Pattern: "
	let pattern = (!exists("a:2"))? inputdialog(mesg, "", "") : a:2
	if pattern == ""
		echo "VimGrep: cancelled."
		return
	endif

	" reopen vimgrep result.
	let cmd = ":vimgrep ". pattern. " ". file
	echo cmd. " (cwd=\"". getcwd(). "\")"
	exec cmd
endfunction

"-----------------------------------------------------------------------------
" Cfile
"-----------------------------------------------------------------------------
function! vimtunes.Cfile(...) dict
	" Cfile
	command! -nargs=* -complete=file Cfile
	    \ :call vimtunes.CfileCommand(<f-args>)
endfunction

function! vimtunes.CfileCommand(...) dict
	" reopen vimgrep result.
	let &errorformat="%f|%l\ col\ %c|\ %m"
	exec ":cfile ". join(a:000, " ")
endfunction

"-----------------------------------------------------------------------------
" autoreopen
"-----------------------------------------------------------------------------
function! vimtunes.autoreopen(...) dict
	autocmd FileType * :call vimtunes.ReopenCurrentBufferByAssociatedApplication()
endfunction

function! vimtunes.ReopenCurrentBufferByAssociatedApplication() dict
	if self.OpenCurrentBufferByAssociatedApplication() != 0
		q! " close if open succeeded.
	endif
endfunction

function! vimtunes.OpenCurrentBufferByAssociatedApplication() dict
	let file = expand("%:p")
	let ext  = fnamemodify(file, ":e")
	if ext == "sln"
		return self.OpenMonoDevelop(file)
	endif
	return 0
endfunction

function! vimtunes.OpenMonoDevelop(slnFile) dict
	if has("win32") "windows
		call self.registry_request_setpath("MonoDevelop", "Mono Develop (MonoDevelop.exe) for edit .sln on Windows", "")
	elseif has("win32unix") "cygwin
		call self.registry_request_setpath("MonoDevelop", "Mono Develop (MonoDevelop.exe) for edit .sln on cygwin", "")
	elseif has("mac") "mac
		call self.registry_request_setpath("MonoDevelop", "Mono Develop (MonoDevelop) for edit .sln on mac", "")
	elseif has("unix") "unix
		call self.registry_request_setpath("MonoDevelop", "Mono Develop (MonoDevelop) for edit .sln on unix", "")
	endif
	if self.registry_check("MonoDevelop")
		let monoDevelop = self.registry_request("MonoDevelop", "For edit .sln", "")
		call self.OpenCommand("\"". monoDevelop. "\" \"". a:slnFile. "\"")
		return 1
	endif
	return 0
endfunction

function! vimtunes.OpenCommand(cmd)
	if isdirectory(g:neobundle_dir) && neobundle#is_installed('vim-dispatch')
		exec "Start ". a:cmd
	else
		call system(a:cmd)
	endif
endfunction

"-----------------------------------------------------------------------------
" statusline
"-----------------------------------------------------------------------------
let vimtunes.statusline_disable_custom_design = 0
function! vimtunes.statusline(...) dict
	if !self.statusline_disable_custom_design
		set statusline=
		    \%#StatusLineBar#
		    \\ \|%*\ \ \ %{winnr()}\ \ \ %#StatusLineBar#\|
		    \\ \%F
		    \\ %{'[v]'.(vimtunes.build_view_formatencoding())}
		    \\ %{'=>'}
		    \%{'[e]'.(vimtunes.build_file_formatencoding())}
		    \\ \%=%m\%*\ \ %c,\ %l/%L\ \(%P\)
	endif
endfunction

function! vimtunes.build_file_formatencoding(...) dict
	let sc = ","
	if exists("a:1")
		let sc = a:1
	endif
	let linefeed = self.get_file_linefeed()
	let line = (linefeed == self.get_view_linefeed())? "" : linefeed
	if self.use2["multibyte"]
		let encoding = self.get_file_encoding()
		let line = ((encoding == self.get_view_encoding())?
		    \ "" : encoding). sc. line
	endif
	return line
endfunction

function! vimtunes.build_view_formatencoding(...) dict
	let sc = ","
	if exists("a:1")
		let sc = a:1
	endif
	let line = self.get_view_linefeed()
	if self.use2["multibyte"]
		let line = self.get_view_encoding(). sc. line
	endif
	let line = line. ((&bomb == 0)? "" : sc. "bom")
	return line
endfunction

"-----------------------------------------------------------------------------
" rulerline (experimental)
"-----------------------------------------------------------------------------
let vimtunes.rulerline_disable_custom_design = 0
function! vimtunes.rulerline(...) dict
	if !self.rulerline_disable_custom_design
		"set laststatus=0
		set rulerformat=
		    \%60(%=
		    \\|%{winnr()}\|
		    \\ \%F
		    \\ %{'[v]'.vimtunes.build_view_formatencoding()}
		    \\ %m\%*%c,\ %l/%L\ \(%P\)
		    \%)
	endif
endfunction

"-----------------------------------------------------------------------------
" tabline
"-----------------------------------------------------------------------------
let vimtunes.tabline_disable_custom_design = 0
function! vimtunes.tabline(...) dict
	" tabline
	if !self.tabline_disable_custom_design
		set tabline=%!vimtunes.build_tabline()
	endif
	" keymap
	nmap <silent> .     <Esc>:tabnext<CR>
	nmap <silent> ,     <Esc>:tabprev<CR>
	"nmap <silent> <C-n> <Esc>:tab split<CR>
	vmap <silent> <C-n> y<Esc>:tab split<CR>:e `=tempname()`<CR>
	    \p<ESC>Gdd:w<CR>
	" keyhook
	call s:keyhook_add(
	    \ "9_tabline", "CnCp",
	    \ "s:tabline_keyhook_active",
	    \ "s:tabline_keyhook_inactive")
	call s:keyhook_active("9_tabline")
endfunction

function! s:tabline_keyhook_active()
	nmap <silent> <C-n> <Esc>:tab split<CR>
	noremap <C-p> <C-i>
endfunction
function! s:tabline_keyhook_inactive()
	nunmap <C-n>
	nunmap <C-p>
endfunction

function! vimtunes.build_tabline() dict
	let disptabs = []
	let distance = 0
	let selnr    = 0
	let tabnr    = tabpagenr('$')
	let selnr    = tabpagenr()
	for i in range(tabnr)
		" get buffer name
		let bufnrlist = tabpagebuflist(i + 1)
		let bufnr     = len(bufnrlist)
		let winnr     = tabpagewinnr(i + 1)
		let bufname   = bufname(bufnrlist[winnr - 1])
		let buftoks   = split(bufname, '[\/]')
		let bufname   = get(buftoks, len(buftoks) - 1, bufname)
		let selected  = ((i + 1) == selnr)? 1 : 0
		" modified ?
		let modified = 0
		for bnr in bufnrlist
			if getbufvar(bnr, "&modified")
				let modified = 1
				break
			endif
		endfor
		" prefix and postfix
		if selected
			let head  = (i == 0)? ' ' : '  '
			let mark  = (bufnr > 1)? bufnr : ''
			let mark .= (modified)? '+ ' : ''
			let mspc  = (mark == '')? '' : ' '
			let tail  = '  '
			let head_s = '%#TabLineSel#'. head
			let mark_s = (mark == '')? '' :
			           \ '%#TabLineBufsSel#'. mark
			           \ . '%#TabLineSel#'. mspc
			let tail_s = tail
		else
			let head  = (i == 0 || i == selnr)? ' ' : '| '
			let mark  = (bufnr > 1)? bufnr : ''
			let mark .= (modified)? '+' : ''
			let mspc  = (mark == '')? '' : ' '
			let tail  = ' '
			let head_s = '%#TabLine#'. head
			let mark_s = (mark == '')? '' :
			           \ '%#TabLineBufs#'. mark
			           \ . '%#TabLine#'. mspc
			let tail_s = tail
		endif
		" add to display data
		let distance = len(bufname. head. mark. tail)
		let dat = [bufname, head_s, mark_s, tail_s, distance]
		call add(disptabs, dat)
	endfor

	let line     = '%*'
	let cnt      = 1
	let more     = '|>>'
	let morelen  = len(more)
	let distance = 0
	for t in disptabs
		" check character bound
		if cnt >= selnr
			let distance += t[4]
			if (distance + morelen) > winwidth(0)
				let line .= more
				break
			endif
		endif
		" add to line
		let line .= '%' . cnt . 'T'
		let line .= t[1]. t[2]. t[0]. t[3]
		let cnt += 1
	endfor

	let line .= '%#TabLineFill#%=%#TabLine#%999X'
	return line
endfunction

"-----------------------------------------------------------------------------
" guitablabel
"-----------------------------------------------------------------------------
function! vimtunes.guitablabel(...) dict
	set guitablabel=%!vimtunes.build_guitablabel()
endfunction

function! vimtunes.build_guitablabel()
	let label = ''
	" Append the number of windows in the tab page if more than one
	let bufnrlist = tabpagebuflist(v:lnum)
	if len(bufnrlist) > 1
		let label .= len(bufnrlist)
	endif
	" Add '+' if one of the buffers in the tab page is modified
	for bufnr in bufnrlist
		if getbufvar(bufnr, "&modified")
			let label .= '+'
			break
		endif
	endfor
	" Add ' ' if modifier exists
	if label != ''
		let label .= ' '
	endif
	" Append the buffer name
	let bufname = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
	let label .= fnamemodify(bufname, ":t")
	return label
endfunction

"-----------------------------------------------------------------------------
" registry
"-----------------------------------------------------------------------------
function! vimtunes.registry(...) dict
	if expand("%:p") == $HOME. "/.vimrc"
		nmap <buffer> <Tab> :call vimtunes.registry_toggle()<CR>
		autocmd VimEnter *
			\ redraw
			\ | echo "[TAB] to toggle window for Registry File."
	endif
endfunction

"#############################################################################
"###                            LOCAL FUNCTION                             ###
"#############################################################################

" window resize (width)
function! vimtunes.wresize(...) dict
	let nr = winnr()
	if winwidth(nr) < a:1
		exec "vertical resize ". string(a:1)
	endif
endfunction

" window resize (height)
function! vimtunes.hresize(...) dict
	let nr = winnr()
	if winheight(nr) < a:1
		exec "resize ". string(a:1)
	endif
endfunction

"#############################################################################
"###                       SHELL COMMAND FUNCTION                          ###
"#############################################################################

" path
function! vimtunes.set_path(...) dict
	if has("win32")
		let $PATH .= ";". a:1
	else
		let $PATH .= ":". a:1
	end
endfunction

" mkdir
function! vimtunes.mkdir(...) dict
	if has("win32")
		exec "silent !mkdir ". a:1
	else
		exec "silent !mkdir -p ". a:1
	end
endfunction

" rmrf
function! vimtunes.rmrf(...) dict
	if has("win32")
		exec "silent !rmdir /Q /S ". a:1
	else
		exec "silent !rm -rf ". a:1
	end
endfunction

" cp
function! vimtunes.cp(...) dict
	if has("win32")
		exec "silent !xcopy /C /Y /E /I ". a:1. " ". a:2
	else
		exec "silent !cp -r ". a:1. " ". a:2
	end
endfunction

" unzip
function! vimtunes.unzip(...) dict
	exec "silent !unzip -o ". a:1
endfunction

" wget
function! vimtunes.wget(...) dict
	exec "silent !wget -O ". a:2. " ". a:1.
	 \ " --no-check-certificate"
endfunction

" open
"function! vimtunes.open(...) dict
"	if has("win32")
"		exec "silent !start ". a:0
"	else
"		exec "silent !open ". a:0
"	endif
"endfunction

" git
function! vimtunes.git(url, dir, branch) dict
	if empty(a:dir) | echo "name is empty." | return | endif
	if isdirectory(a:dir) | call self.rmrf(a:dir) | endif
	call mkdir(a:dir)
	exec "cd ". a:dir
	echo system("git init")
	echo system("git remote add origin ". a:url)
	echo system("git pull -u origin ". a:branch)
	echo system("git checkout -b ". a:branch)
	exec "cd -"
endfunction

"#############################################################################
"###                          REGISTRY FUNCTION                            ###
"#############################################################################
let g:vimrc_registry = $HOME. "/.vimrc.registry.". $VIM_PLATFORM "<-Attention!
let g:registry_is_vim_entered = 0
let g:registry_is_loaded      = 0
let g:registry = {}

" hook and mark when vim entered
autocmd VimEnter * :let g:registry_is_vim_entered = 1

" check registry key existence
function! vimtunes.registry_contains(key)
	return exists("g:registry[a:key]")
endfunction

" check registry value existence for key
function! vimtunes.registry_check(key)
	let path = exists("g:registry[a:key]")? g:registry[a:key] : ""
	if path == "!" || path == ""
		return 0
	endif
	return 1
endfunction

" get registry value for key
" function! vimtunes.registry_get(key)
" 	let path = exists("g:registry[a:key]")? g:registry[a:key] : ""
" 	if path == "!" || path == ""
" 		return ""
" 	endif
" 	return path
" endfunction

" request registry value for key.
function! vimtunes.registry_request(key, desc, defval) dict
	call self.registry_load()
	let path = exists("g:registry[a:key]")? g:registry[a:key] : ""
	if path == "!"
		return ""
	endif
	if path == "" || !(executable(path) || isdirectory(path))
		if g:registry_is_vim_entered == 1
			call self.registry_input(
			 \ a:key,
			 \ a:desc,
			 \ a:defval)
		else
			exec "autocmd VimEnter * "
			 \ . " :call vimtunes.registry_input("
			 \ . "\"". a:key.    "\","
			 \ . "\"". a:desc.   "\","
			 \ . "\"". a:defval. "\")"
		endif
		return ""
	endif
	return path
endfunction

" show help message
function! vimtunes.registry_confirm_once(key, desc) dict
	call self.registry_load()
	if !self.registry_contains(a:key)
		if g:registry_is_vim_entered == 1
			call self.registry_confirm_once_common(
			 \ a:key,
			 \ a:desc)
			return
		else
			exec "autocmd VimEnter * "
			 \ . " call vimtunes.registry_confirm_once_common("
			 \ . "\"". a:key.  "\", "
			 \ . "\"". a:desc. "\")"
		endif
	endif
endfunction
function! vimtunes.registry_confirm_once_common(key, desc) dict
	if confirm(a:desc, "OK\nRemind this again") == 1
		call self.registry_set(a:key, "!")
	endif
endfunction

" request $PATH env
function! vimtunes.registry_request_setpath(key, desc, defval) dict
	let path = self.registry_request(a:key, a:desc, a:defval)
	if path == ""
		return ""
	endif
	" TODO: change order if value already exists
	if executable(path)
		let path = fnamemodify(path, ":h")
	endif
	if has("win32")
		let $PATH .= ";". path
	else
		let $PATH .= ":". path
	endif
endfunction

" request filename
function! vimtunes.registry_request_filename(key, desc, defval) dict
	let path = self.registry_request(a:key, a:desc, a:defval)
	if path == ""
		return ""
	endif
	return fnamemodify(path, ":t")
endfunction

" input registry key
function! vimtunes.registry_input(key, desc, defval) dict
	let regval  = exists("g:registry[a:key]")? g:registry[a:key] : ""
	let text    = (regval == "")? a:defval : regval
	let prompt  = "Enter Path '". a:key. "'"
	let prompt .= (a:desc != "")? " (". a:desc. ")" : ""
	let prompt .= " ['!' to stop asking]: "
	while 1
		let path = inputdialog(prompt, text, -1)
		if path == -1 || path == "" || path == "!"
		 \ || (executable(path) || isdirectory(path))
			let path = (path == -1)? "" : path
			break
		endif
	endwhile
	call self.registry_set(a:key, path)
endfunction

" set registry key
function! vimtunes.registry_set(key, val) dict
	if a:val != ""
		let g:registry[a:key] = a:val
		call self.registry_save((a:val == "!")? 0 : 1)
	else
		if exists("g:registry[a:key]")
			call remove(g:registry, a:key)
			call self.registry_save(0)
		else
			echom "Registry Setting for '". a:key. "' is cancelled."
		endif
	endif
endfunction

" load registry from file
function! vimtunes.registry_load() dict
	if g:registry_is_loaded == 0 && filereadable(g:vimrc_registry)
		let g:registry_is_loaded = 1
		exec "source ". g:vimrc_registry
	endif
endfunction

" save registry to file
function! vimtunes.registry_save(need_confirm) dict
	let lines = []
	for i in keys(g:registry)
		let line  = "let g:registry['". i. "']"
		let line .= " = '". g:registry[i]. "'"
		call add(lines, line)
	endfor
	silent call writefile(lines, g:vimrc_registry)
	if a:need_confirm
		let mesg = "***** Registry updated! RESTARTING VIM is required! **** "
		call confirm(mesg, "OK")
	endif
endfunction

" open registry window (on vim)
function! vimtunes.registry_open(focus) dict
	if !filereadable(g:vimrc_registry)
		return
	endif
	let nr = self.registry_tabbufnr(g:vimrc_registry)
	if nr >= 0
		if a:focus
			exec nr. "wincmd w"
		endif
	else
		let nr = bufnr("$")
		botright split
		resize 5
		exec "silent edit ". g:vimrc_registry
		nmap <buffer> <Tab> :call vimtunes.registry_toggle()<CR>
		if !a:focus
			exec nr. "wincmd w"
		endif
	endif
endfunction

" close registry window (on vim)
function! vimtunes.registry_close() dict
	let nr = self.registry_tabbufnr(g:vimrc_registry)
	if nr >= 0
		exec nr. "wincmd w"
		exec "q!"
	endif
endfunction

" toggle registry window (on vim)
function! vimtunes.registry_toggle() dict
	let nr = self.registry_tabbufnr(g:vimrc_registry)
	let rf = g:vimrc_registry
	if nr < 0
		call self.registry_open(1)
		redraw | echo "Window for Registry File '". rf. "' opened."
	else
		call self.registry_close()
		redraw | echo "Window for Registry File '". rf. "' closed."
	endif
endfunction

" registry_tabbufnr (utility function)
function! vimtunes.registry_tabbufnr(n)
	let buflist = tabpagebuflist()
	for bufnr in buflist
		let bufn = fnamemodify(bufname(bufnr), ":p")
		if bufn == a:n
			return bufnr
		endif
	endfor
	return -1
endfunction

"#############################################################################
"###                              KEYHOOKS                                 ###
"#############################################################################
let g:keyhooks = {}
let g:activehooks = {}
let g:curhook = ''

function! s:keyhook_add(name, region, active_funcname, inactive_funcname)
	let g:keyhooks[a:name] =
	    \ [a:region, a:active_funcname, a:inactive_funcname]
endfunction

function! s:keyhook_active(name)
	let hook   = g:keyhooks[a:name]
	let region = hook[0]
	if !exists("g:activehooks[region]")
		let g:activehooks[region] = {}
	endif
	let g:activehooks[region][a:name] = 1
	call s:keyhook_primary(g:activehooks[region])
endfunction

function! s:keyhook_inactive(name)
	let hook   = g:keyhooks[a:name]
	let region = hook[0]
	unlet g:activehooks[region][a:name]
	call s:keyhook_primary(g:activehooks[region])
endfunction

function! s:keyhook_primary(activehooks)
	let keys = sort(keys(a:activehooks))
	let primary = ''
	if len(keys) > 0
		let primary = keys[0]
	endif
	if primary != g:curhook
		if g:curhook != ''
			let funcname = g:keyhooks[g:curhook][2]
			exec ":call ". funcname. "()"
		endif
		if primary != ''
			let funcname = g:keyhooks[primary][1]
			exec ":call ". funcname. "()"
		endif
		let g:curhook = primary
	endif
endfunction

"#############################################################################
"###                             CONFIGMATRIX                              ###
"#############################################################################

function! CONFIGMATRIX_new(...) dict
	let obj = copy(self)
	" init instance
	let obj._var    = a:1
	let obj._init   = a:2
	let obj._reset  = a:3
	let obj._matrix = a:4
	return obj
endfunction

function! CONFIGMATRIX_current(...) dict
	if !exists(self._var)
		exec "let ". self._var. "=". self._init
	endif
	" set current (if argument exists)
	if exists("a:1")
		exec "let ". self._var. "='". a:1. "'"
	endif
	" check value illegal
	exec "let key=". self._var
	if !exists("self._matrix[key]")
		exec "let ". self._var. "=". self._reset
	endif
	exec "return ". self._var
endfunction

function! CONFIGMATRIX_rotate() dict
	let key = self.current()
	if exists("self._matrix[key]")
		exec "let ". self._var. "='". self._matrix[key]. "'"
	else
		exec "let ". self._var. "=". self._reset
	endif
	exec "return ". self._var
endfunction

" class CONFIGMATRIX
let CONFIGMATRIX = {
    \ "new"	: function("CONFIGMATRIX_new"),
    \ "current"	: function("CONFIGMATRIX_current"),
    \ "rotate"	: function("CONFIGMATRIX_rotate"),
    \ "_var"	: "_",
    \ "_init"	: "0",
    \ "_reset"	: "0",
    \ "_matrix"	: {},
    \ }

"#############################################################################
"###                              HIGHLIGHT                                ###
"#############################################################################

" syntax-highlight color scheme
let HIGHLIGHT = {}
let HIGHLIGHT.syntax = {}
let HIGHLIGHT.syntax["Normal"]		= ["fore",     "back",     "none"]
let HIGHLIGHT.syntax["NonText"]		= ["fore",     "back",     "none"]
let HIGHLIGHT.syntax["Visual"]		= ["visualfg", "visualbg", "visual"]
" programming
let HIGHLIGHT.syntax["Comment"]		= ["green",   "bg", "none"]
let HIGHLIGHT.syntax["Constant"]	= ["yellow",  "bg", "none"]
let HIGHLIGHT.syntax["Identifier"]	= ["fore",    "bg", "none"]
let HIGHLIGHT.syntax["Statement"]	= ["cyan",    "bg", "none"]
let HIGHLIGHT.syntax["Type"]		= ["cyan",    "bg", "none"]
let HIGHLIGHT.syntax["PreProc"]		= ["special", "bg", "none"]
let HIGHLIGHT.syntax["Special"]		= ["special", "bg", "none"]
let HIGHLIGHT.syntax["SpecialComment"]	= ["green",   "bg", "none"]
" statusline
let HIGHLIGHT.syntax["StatusLine"]	= ["status", "back",  "none"]
let HIGHLIGHT.syntax["StatusLineNC"]	= ["black",  "status", "none"]
let HIGHLIGHT.syntax["StatusLineBar"]	= ["black",  "status", "underline2"]
" tabline
let HIGHLIGHT.syntax["TabLine"]		= ["black",   "tab",  "underline2"]
let HIGHLIGHT.syntax["TabLineSel"]	= ["tab",     "back", "none"]
let HIGHLIGHT.syntax["TabLineBufs"]	= ["magenta", "tab",  "none"]
let HIGHLIGHT.syntax["TabLineBufsSel"]	= ["magenta", "back", "none"]
let HIGHLIGHT.syntax["TabLineFill"]	= ["black",   "tab",  "underline2"]
" misc
let HIGHLIGHT.syntax["SpecialKeyRed"]	= ["red",    "bg",     "none"]
let HIGHLIGHT.syntax["SpecialKeyBlue"]	= ["blue",   "bg",     "none"]
let HIGHLIGHT.syntax["SpecialKey"]	= HIGHLIGHT.syntax["SpecialKeyRed"]
let HIGHLIGHT.syntax["Search"]		= ["fore",   "red",    "none"]
let HIGHLIGHT.syntax["Folded"]		= ["foldfg", "foldbg", "none"]
let HIGHLIGHT.syntax["Directory"]	= ["red",    "bg",     "none"]
let HIGHLIGHT.syntax["LineNr"]		= ["line",   "blue",   "underline"]
let HIGHLIGHT.syntax["MatchParen"]	= ["red",    "bg",     "none"]
" Diff
let HIGHLIGHT.syntax["DiffAdd"]		= ["fore",    "red",  "none"]
let HIGHLIGHT.syntax["DiffDelete"]	= ["black",   "red",  "none"]
let HIGHLIGHT.syntax["DiffChange"]	= ["fore",    "blue", "none"]
let HIGHLIGHT.syntax["DiffText"]	= ["magenta", "blue", "none"]
" diff
let HIGHLIGHT.syntax["diffAdded"]	= HIGHLIGHT.syntax["DiffAdd"]
let HIGHLIGHT.syntax["diffRemoved"]	= HIGHLIGHT.syntax["DiffDelete"]
let HIGHLIGHT.syntax["diffChanged"]	= HIGHLIGHT.syntax["DiffChange"]
let HIGHLIGHT.syntax["diffLine"]	= HIGHLIGHT.syntax["DiffText"]
let HIGHLIGHT.syntax["diffFile "]	= ["green", "bg", "none"]
let HIGHLIGHT.syntax["diffOldFile"]	= ["green", "bg", "none"]
let HIGHLIGHT.syntax["diffNewFile"]	= ["green", "bg", "none"]
" PopUp Menu
let HIGHLIGHT.syntax["Pmenu"]		= ["green", "black", "none"]
let HIGHLIGHT.syntax["PmenuSel"]	= ["black", "fore",  "none"]
let HIGHLIGHT.syntax["PmenuSbar"]	= ["green", "black", "none"]
let HIGHLIGHT.syntax["PmenuThumb"]	= ["green", "black", "none"]
" folding
let HIGHLIGHT.syntax["Folded"]		= ["red",   "bg",    "none"]
let HIGHLIGHT.syntax["FoldColumn"]	= ["black", "green", "none"]
" minor Fix
let HIGHLIGHT.syntax["vimFunc"]		= HIGHLIGHT.syntax["Normal"]
let HIGHLIGHT.syntax["Ignore"]		= HIGHLIGHT.syntax["Special"]
" feature specialized
let HIGHLIGHT.syntax["OverCol"]		= ["none",   "none",  "underline"]
let HIGHLIGHT.syntax["CsTemplateCS"]	= ["yellow", "none",  "none"]
let HIGHLIGHT.syntax["CsTemplateTP"]	= ["green",  "none",  "bold"]
let HIGHLIGHT.syntax["shDerefWordError"]= ["yellow", "none",  "bold"]

" syntax-highlight scheme mapping
let HIGHLIGHT.map = {}
let HIGHLIGHT.map.mono = {
    \ "guifg" : -1, "guibg" : -1, "gui" : -1,
    \ "ctermfg" : -1, "ctermbg" : -1, "cterm" : -1,
    \ "term" : 2 }
let HIGHLIGHT.map.cterm = {
    \ "guifg" : -1, "guibg" : -1, "gui" : -1,
    \ "ctermfg" : 0, "ctermbg" : 1, "cterm" : 2,
    \ "term" : -1 }
let HIGHLIGHT.map.gui = {
    \ "guifg" : 0, "guibg" : 1, "gui" : 2,
    \ "ctermfg" : -1, "ctermbg" : -1, "cterm" : -1,
    \ "term" : -1 }

" syntax-highlight color library
let HIGHLIGHT.colors = {}
let HIGHLIGHT.colors.toybox16 = {
  \ "fore" : "LightGray", "back" : "0",
  \ "black" : "Black",
  \ "green" : "DarkGreen",
  \ "cyan" : "DarkCyan",
  \ "blue" : "DarkBlue",
  \ "yellow" : "DarkYellow", "special" : "DarkYellow",
  \ "red" : "DarkRed",
  \ "magenta" : "Magenta",
  \ "status" : "LightGray",
  \ "tab" : "LightGray",
  \ "line" : "LightGray",
  \ "foldfg" : "Black", "foldbg" : "DarkRed",
  \ "visualfg" : "", "visualbg" : "", "visual" : "reverse",
  \ "underline" : "underline", "underline2" : "underline",
  \ "bold" : "bold",
  \ "fg" : "fg", "bg" : "bg", "none" : "NONE",
  \ }
let HIGHLIGHT.colors.toybox = {
  \ "fore" : "#eeffee",
  \ "back" : "#112233",
  \ "black" : "#112233",
  \ "green" : "#22ff44",
  \ "cyan" : "#22ddcc",
  \ "blue" : "#3344aa",
  \ "yellow" : "#ddee22", "special" : "#e4dc22",
  \ "red" : "#ee2211",
  \ "magenta" : "#cc4400",
  \ "status" : "#8899aa",
  \ "tab" : "#556677",
  \ "line" : "#556677",
  \ "foldfg" : "#cc4400", "foldbg": "#2c2024",
  \ "visualfg" : "", "visualbg" : "#3868cf", "visual" : "",
  \ "underline" : "underline", "underline2" : "underline",
  \ "bold" : "bold",
  \ "fg" : "fg", "bg" : "bg", "none" : "NONE",
  \ }
let HIGHLIGHT.colors.horror = {
  \ "fore" : "#aaffcc",
  \ "back" : "#1c2024",
  \ "black" : "#1c2024",
  \ "green" : "#22aa44",
  \ "cyan" : "#80c0ee",
  \ "blue" : "#223377",
  \ "yellow" : "#ddcc88", "special" : "#ddcc88",
  \ "red" : "#cc4400",
  \ "magenta" : "#cc4400",
  \ "status" : "#8899aa",
  \ "tab" : "#556677",
  \ "line" : "#556677",
  \ "foldfg" : "#cc4400", "foldbg": "#2c2024",
  \ "visualfg" : "", "visualbg" : "#47604c", "visual" : "",
  \ "underline" : "underline", "underline2" : "underline",
  \ "bold" : "bold",
  \ "fg" : "fg", "bg" : "bg", "none" : "NONE",
  \ }

function! HIGHLIGHT_new(...) dict
	let obj = copy(self)
	return obj
endfunction

function! HIGHLIGHT_hi_syntax(n, syntax) dict
	let map   = self.map
	let color = self.color
	let hi = ""
	for j in keys(map)
		let k = map[j]
		if k < 0
			let hi .= " ". j. "=NONE"
		elseif !exists("a:syntax[k]")
			call input('color: '. a:n. ': index overflow')
		elseif !exists("color[a:syntax[k]]")
			call input('color: '. a:n. ': no map '. a:syntax[k])
		elseif color[a:syntax[k]] != ""
			let hi .= " ". j. "=". color[a:syntax[k]]
		endif
	endfor
	exec "highlight ". a:n. hi
endfunction

function! HIGHLIGHT_hi(...) dict
	" let value to 'self.color' before calling self.hi_syntax()
	let colorname = a:1
	let self.color = self.colors[colorname]
	let syntax = self.syntax
	if exists("syntax['Normal']")
		call self.hi_syntax("Normal", syntax["Normal"])
		unlet syntax["Normal"]
	endif
	for i in keys(syntax)
		call self.hi_syntax(i, syntax[i])
	endfor
endfunction

" class HIGHLIGHT_MONO
let HIGHLIGHT_MONO = {
    \ "new"		: function("HIGHLIGHT_new"),
    \ "hi"		: function("HIGHLIGHT_hi"),
    \ "hi_syntax"	: function("HIGHLIGHT_hi_syntax"),
    \ "syntax"		: g:HIGHLIGHT.syntax,
    \ "colors"		: g:HIGHLIGHT.colors,
    \ "map"		: g:HIGHLIGHT.map.mono,
    \ "color"		: "",
    \ }
" class HIGHLIGHT_CTERM
let HIGHLIGHT_CTERM = {
    \ "new"		: function("HIGHLIGHT_new"),
    \ "hi"		: function("HIGHLIGHT_hi"),
    \ "hi_syntax"	: function("HIGHLIGHT_hi_syntax"),
    \ "syntax"		: g:HIGHLIGHT.syntax,
    \ "colors"		: g:HIGHLIGHT.colors,
    \ "map"		: g:HIGHLIGHT.map.cterm,
    \ "color"		: "",
    \ }
" class HIGHLIGHT_GUI
let HIGHLIGHT_GUI = {
    \ "new"		: function("HIGHLIGHT_new"),
    \ "hi"		: function("HIGHLIGHT_hi"),
    \ "hi_syntax"	: function("HIGHLIGHT_hi_syntax"),
    \ "syntax"		: g:HIGHLIGHT.syntax,
    \ "colors"		: g:HIGHLIGHT.colors,
    \ "map"		: g:HIGHLIGHT.map.gui,
    \ "color"		: "",
    \ }

"#############################################################################
"###                              TUNE ALL                                 ###
"#############################################################################
call vimtunes.tune("use0", use0)
call vimtunes.tune("use1", use1)
call vimtunes.tune("use2", use2)
call vimtunes.tune("use9", use9)

