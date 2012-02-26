" following http://vim.wikia.com/wiki/VimTip857
" and http://vimdoc.sourceforge.net/htmldoc/syntax.html#:syn-include
if exists('b:current_syntax')
	let s:current_syntax=b:current_syntax
	" Remove current syntax definition, as some syntax files (e.g. cpp.vim)
	" do nothing if b:current_syntax is defined.
	unlet b:current_syntax
endif

" get SQL highlighting in java strings
syn include @sqlTop syntax/mysql.vim

" restore current_syntax
if exists('s:current_syntax')
	let b:current_syntax=s:current_syntax
else
	unlet b:current_syntax
endif

syn cluster sqlTop remove=mysqlString,mysqlComment
syn region javaString start=+"+ end=+"+ end=+$+ contains=@sqlTop containedin=javaString keepend

