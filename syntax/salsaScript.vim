" Vim Syntax File
" Language: SalsaScript
" Author: Perry Wong <pwong@salsalabs.com>
" Adapted from jsp.vim

if version < 600
  syntax clear
elseif exists("b:current_syntax")
	finish
endif

if !exists("main_syntax")
  let main_syntax = 'salsaScript'
endif

" Source HTML syntax
if version < 600
  source <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
endif
unlet b:current_syntax

" Next syntax items are case-sensitive
syn case match

" Include JavaScript syntax
syn include @sjsJavaScript syntax/javascript.vim

syn region sjsScriptlet matchgroup=sjsTag start=/<?/  keepend end=/?>/ contains=@sjsJavaScript,sjsObject
syn region sjsExpr	matchgroup=sjsTag start=/<?=/ keepend end=/?>/ contains=@sjsJavaScript,sjsObject
syn region sjsInclude			  start=/<?@include/	      end=/?>/ contains=htmlString

syn keyword sjsObject contained Request Response DB salsa Condition Crawler DB Email Flash Geo Graphics Java Locale Log Object Package Request Response Score Session String Supporter

" Redefine htmlTag so that it can contain jspExpr
syn clear htmlTag
syn region htmlTag start=+<[^/?]+ end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,sjsExpr,javaScript

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sjs_syn_inits")
  if version < 508
    let did_sjs_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  " Be consistent with html highlight settings
  HiLink sjsTag		 htmlTag
  HiLink sjsInclude	 sjsTag
  HiLink sjsObject	Identifier
  delcommand HiLink
endif

if main_syntax == 'salsaScript'
  unlet main_syntax
endif

let b:current_syntax = "salsaScript"

" vim: ts=4
