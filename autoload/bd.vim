function! bd#ChangeToParentDir(startPath, dirName, cdCmd) abort
	let l:dirs = split(a:startPath, '/')
	for l:i in range(len(l:dirs) - 1, 0, -1)
		if l:dirs[l:i] == a:dirName
			let l:targetDir = '/' . join(l:dirs[:l:i], '/')
			execute a:cdCmd . ' ' . l:targetDir
			echo 'Changed directory to ' . l:targetDir
			return
		endif
	endfor
	echo 'Directory not found: ' . a:dirName
endfunction

function! s:DirCompletion(startPath, ArgLead, CmdLine, CursorPos) abort
	let l:dirs = []
	let l:items = split(a:startPath, '/')

	for l:item in l:items
		if stridx(l:item, a:ArgLead) == 0
			call add(l:dirs, l:item)
		endif
	endfor

	return l:dirs
endfunction

function bd#PwdComplete(ArgLead, CmdLine, CursorPos)
	return s:DirCompletion(getcwd(), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction
function bd#CfileComplete(ArgLead, CmdLine, CursorPos)
	return s:DirCompletion(expand('%:p:h'), a:ArgLead, a:CmdLine, a:CursorPos)
endfunction

