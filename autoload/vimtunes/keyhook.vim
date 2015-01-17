"#############################################################################
"###                              KEYHOOKS                                 ###
"#############################################################################
if exists('g:autoloaded_vimtunes_keyhook')
  finish
endif
let g:autoloaded_vimtunes_keyhook = 1

let s:keyhooks    = {}
let s:activehooks = []
let s:curhooks    = {}
let s:unmapcmd    = {
\	"map"      : "unmap",
\	"nmap"     : "nunmap",
\	"imap"     : "iunmap",
\	"cmap"     : "cunmap",
\}

" map aliases
function! vimtunes#keyhook#map(key, ...)
	call s:add_map("map", a:key, a:000)
endfunction
function! vimtunes#keyhook#nmap(key, ...)
	call s:add_map("nmap", a:key, a:000)
endfunction
function! vimtunes#keyhook#imap(key, ...)
	call s:add_map("imap", a:key, a:000)
endfunction
function! vimtunes#keyhook#cmap(key, ...)
	call s:add_map("cmap", a:key, a:000)
endfunction

" hook aliases
function! vimtunes#keyhook#hook(hookname, key, ...)
	call s:add_hook(a:hookname, "map", a:key, a:000)
endfunction
function! vimtunes#keyhook#nhook(hookname, key, ...)
	call s:add_hook(a:hookname, "nmap", a:key, a:000)
endfunction
function! vimtunes#keyhook#ihook(hookname, key, ...)
	call s:add_hook(a:hookname, "imap", a:key, a:000)
endfunction
function! vimtunes#keyhook#chook(hookname, key, ...)
	call s:add_hook(a:hookname, "cmap", a:key, a:000)
endfunction

" activate hook
function! vimtunes#keyhook#activate(hookname)
	if !exists("s:keyhooks[a:hookname]")
		throw "hook '". a:hookname. "' does not exists."
	endif
	let index = match(s:activehooks, a:hookname)
	if index < 0
		call add(s:activehooks, a:hookname)
		call s:update()
	endif
endfunction

" deactivate hook
function! vimtunes#keyhook#deactivate(hookname)
	if !exists("s:keyhooks[a:hookname]")
		throw "hook '". a:hookname. "' does not exists."
	endif
	let index = match(s:activehooks, a:hookname)
	if index >= 0
		call remove(s:activehooks, index)
		call s:update()
	endif
endfunction

" add default map
function! s:add_map(mapcmd, key, args)
	call s:add_hook("default", a:mapcmd, a:key, a:args)
endfunction

" add hook map
function! s:add_hook(hookname, mapcmd, key, args)
	let expr    = (exists("a:args[0]"))? a:args[0] : ""
	let options = (exists("a:args[1]"))? a:args[1] : ""
	if !exists('s:unmapcmd[a:mapcmd]')
		throw "mapcmd '". a:mapcmd. "' does not supported."
		    . " supported commands are: "
		    . "[". join(keys(a:unmapcmd), ", "). "]"
	endif
	" auto add empty map to defaul if not found.
	if a:hookname != "default"
	\  && !exists('s:keyhooks["default"][a:mapcmd][a:key]')
		call s:add_map(a:mapcmd, a:key, [])
	endif
	" overwrite if already map exists.
	if exists('s:keyhooks[a:hookname][a:mapcmd][a:key]')
		if exists('s:curhooks[a:mapcmd][a:key]')
			let curname = s:curhooks[a:mapcmd][a:key]
			if curname == a:hookname
				let s:curhooks[a:mapcmd][a:key] = '<overwritten>'
			endif
		endif
	endif
	" add then update
	if !exists('s:keyhooks[a:hookname]')
		let s:keyhooks[a:hookname] = {}
	endif
	if !exists('s:keyhooks[a:hookname][a:mapcmd]')
		let s:keyhooks[a:hookname][a:mapcmd] = {}
	endif
	let s:keyhooks[a:hookname][a:mapcmd][a:key] = [expr, options]
	call s:update()
endfunction

" update current keyhooks
function! s:update()
	for mapcmd in keys(s:keyhooks["default"])
		for key in keys(s:keyhooks["default"][mapcmd])
			let hookname = "default"
			for name in s:activehooks
				if exists("s:keyhooks[name][mapcmd][key]")
					let hookname = name
				endif
			endfor
			call s:set(hookname, mapcmd, key)
		endfor
	endfor
endfunction

" set hookname's key to current
function! s:set(hookname, mapcmd, key)
	let curname = (exists("s:curhooks[a:mapcmd][a:key]"))? s:curhooks[a:mapcmd][a:key] : ""
	if curname != a:hookname
		if !exists("s:curhooks[a:mapcmd]")
			let s:curhooks[a:mapcmd] = {}
		endif
		let list = s:keyhooks[a:hookname][a:mapcmd][a:key]
		let expr    = list[0]
		let options = list[1]
		" unmap current key
		if curname != ""
			exec s:unmapcmd[a:mapcmd]. " ". a:key
			if exists('s:curhooks[a:mapcmd][a:key]')
				unlet s:curhooks[a:mapcmd][a:key]
			endif
		endif
		" map next key
		if expr != ""
			exec a:mapcmd. " ". options. " ". a:key. " ". expr
			let s:curhooks[a:mapcmd][a:key] = a:hookname
		endif
	endif
endfunction
