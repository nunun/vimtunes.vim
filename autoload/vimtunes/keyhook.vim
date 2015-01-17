"#############################################################################
"###                              KEYHOOKS                                 ###
"#############################################################################
let s:keyhooks    = {}
let s:activehooks = {}
let s:curhook     = ''

function! vimtunes#keyhook#add(name, region, active_funcname, inactive_funcname)
	let s:keyhooks[a:name] =
	    \ [a:region, a:active_funcname, a:inactive_funcname]
endfunction

function! vimtunes#keyhook#active(name)
	let hook   = s:keyhooks[a:name]
	let region = hook[0]
	if !exists("s:activehooks[region]")
		let s:activehooks[region] = {}
	endif
	let s:activehooks[region][a:name] = 1
	call s:keyhook_primary(s:activehooks[region])
endfunction

function! vimtunes#keyhook#inactive(name)
	let hook   = s:keyhooks[a:name]
	let region = hook[0]
	unlet s:activehooks[region][a:name]
	call s:keyhook_primary(s:activehooks[region])
endfunction

function! vimtunes#keyhook#primary(activehooks)
	let keys = sort(keys(a:activehooks))
	let primary = ''
	if len(keys) > 0
		let primary = keys[0]
	endif
	if primary != s:curhook
		if s:curhook != ''
			let funcname = s:keyhooks[s:curhook][2]
			exec ":call ". funcname. "()"
		endif
		if primary != ''
			let funcname = s:keyhooks[primary][1]
			exec ":call ". funcname. "()"
		endif
		let s:curhook = primary
	endif
endfunction
