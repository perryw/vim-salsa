" Vim Syntax File
" Language: SalsaScript
" Author: Perry Wong <pwong@salsalabs.com>
" Adapted from eruby.vim, jsp.vim, javascript.vim

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'salsaScript'
endif

if !exists("b:salsaScript_nest_level")
  let b:salsaScript_nest_level = strlen(substitute(substitute(substitute(expand("%:t"),'@','','g'),'\c\.\%(sjs\)\>','@','g'),'[^@]','','g'))
endif
if !b:salsaScript_nest_level
  let b:salsaScript_nest_level = 1
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn include @jsTop syntax/javascript.vim
syn include @css syntax/css.vim

syn cluster salsaScriptRegions contains=salsaScriptBlock,salsaScriptExpression,javaScript

" erubis is much more flexible than SJS, so we just need to hard-code the
" start & end tags
" TODO: add highlighting for nested SJS e.g. <?@include 'foo?<?=query?>'?>
" :h containedin & :h keepend
" adding fold argument folds the entire region, not the code or tags inside
syn region  salsaScriptBlock      matchgroup=salsaScriptDelimiter start=/<?/ end=/?>/ contains=@jsTop,salsaLib keepend
syn region  salsaScriptExpression matchgroup=salsaScriptDelimiter start=/<?=/ end=/?>/ contains=@jsTop,salsaLib keepend
syn region  salsaInclude matchgroup=salsaScriptInclude start=/<?@include/ end=/?>/ contains=htmlString,salsaScriptExpression keepend
syn keyword salsaLib contained Condition Crawler DB Email Flash Geo Graphics Java Locale Log Package Request Response Score Session salsa Supporter

hi def link salsaScriptDelimiter	Preproc
hi def link salsaScriptInclude		Preproc
hi def link salsaLib				Identifier

" enable JS folding from javascript.vim
syntax match   javaScriptFunction       /\<function\>/ nextgroup=javaScriptFuncName skipwhite
syntax match   javaScriptOpAssign       /=\@<!=/ nextgroup=javaScriptFuncBlock skipwhite skipempty
syntax region  javaScriptFuncName       contained matchgroup=javaScriptFuncName start=/\%(\$\|\w\)*\s*(/ end=/)/ contains=javaScriptLineComment,javaScriptComment nextgroup=javaScriptFuncBlock skipwhite skipempty
syntax region  javaScriptFuncBlock      contained matchgroup=javaScriptFuncBlock start="{" end="}" contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrB,javaScriptParen,javaScriptBracket,javaScriptBlock fold
syn region cssMediaBlock transparent matchgroup=cssBraces start='{' end='}' contains=cssTagName,cssError,cssComment,cssDefinition,cssURL,cssUnicodeEscape,cssIdentifier skipwhite skipempty fold

syn sync fromstart
syn sync maxlines=100

let b:current_syntax = 'salsaScript'

if main_syntax == 'salsaScript'
  unlet main_syntax
endif

" vim: ts=4
