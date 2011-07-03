" Vim Syntax File
" Language: SalsaScript
" Author: Perry Wong <pwong@salsalabs.com>
" Adapted from eruby.vim

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'salsaScript'
endif

if !exists("g:salsaScript_default_subtype")
  let g:salsaScript_default_subtype = "html"
endif

if !exists("b:salsaScript_subtype") && main_syntax == 'salsaScript'
  "let s:lines = getline(1)."\n".getline(2)."\n".getline(3)."\n".getline(4)."\n".getline(5)."\n".getline("$")
  "let b:salsaScript_subtype = matchstr(s:lines,'salsaScript_subtype=\zs\w\+')
  "if b:salsaScript_subtype == ''
  "  let b:salsaScript_subtype = matchstr(&filetype,'^salsaScript\.\zs\w\+')
  "endif
  "if b:salsaScript_subtype == ''
  "  let b:salsaScript_subtype = matchstr(substitute(expand("%:t"),'\c\%(\.sjs\|\.salsaScript\)\+$','',''),'\.\zs\w\+$')
  "endif

  " should never be anything other than html
  "if b:salsaScript_subtype == 'rhtml'
  "  let b:salsaScript_subtype = 'html'
  "elseif b:salsaScript_subtype == 'rb'
  "  let b:salsaScript_subtype = 'ruby'
  "elseif b:salsaScript_subtype == 'yml'
  "  let b:salsaScript_subtype = 'yaml'
  "elseif b:salsaScript_subtype == 'js'
  "  let b:salsaScript_subtype = 'javascript'
  "elseif b:salsaScript_subtype == 'txt'
  "  " Conventional; not a real file type
  "  let b:salsaScript_subtype = 'text'
  "elseif b:salsaScript_subtype == ''
  "  let b:salsaScript_subtype = g:salsaScript_default_subtype
  "endif

  let b:salsaScript_subtype = g:salsaScript_default_subtype
endif

if !exists("b:salsaScript_nest_level")
  let b:salsaScript_nest_level = strlen(substitute(substitute(substitute(expand("%:t"),'@','','g'),'\c\.\%(sjs\)\>','@','g'),'[^@]','','g'))
endif
if !b:salsaScript_nest_level
  let b:salsaScript_nest_level = 1
endif

if exists("b:salsaScript_subtype") && b:salsaScript_subtype != ''
  exe "runtime! syntax/".b:salsaScript_subtype.".vim"
  unlet! b:current_syntax
endif
syn include @jsTop syntax/javascript.vim

syn cluster salsaScriptRegions contains=salsaScriptBlock,salsaScriptExpression

" erubis is much more flexible than SJS, so we just need to hard-code the
" start & end tags
" TODO: add highlighting for nested SJS e.g. <?@include 'foo?<?=query?>'?>
" :h containedin & :h keepend
exe 'syn region  salsaScriptBlock      matchgroup=salsaScriptDelimiter start=/<?/ end=/?>/ contains=@jsTop  containedin=ALLBUT,@salsaScriptRegions keepend'
exe 'syn region  salsaScriptExpression matchgroup=salsaScriptDelimiter start=/<?=/ end=/?>/ contains=@jsTop  containedin=ALLBUT,@salsaScriptRegions keepend'
exe 'syn region  salsaInclude matchgroup=salsaScriptInclude start=/<?@include/ end=/?>/ contains=htmlString,salsaScriptExpression keepend'

" Define the default highlighting.

hi def link salsaScriptDelimiter		PreProc
hi def link salsaScriptInclude		Delimiter

let b:current_syntax = 'salsaScript'

if main_syntax == 'salsaScript'
  unlet main_syntax
endif

" vim: ts=4
