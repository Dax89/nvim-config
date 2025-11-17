if exists('b:current_syntax')
    finish
endif

let b:current_syntax='nil'

let s:cpo_save=&cpo
set cpo&vim

syn case ignore
syn iskeyword 33-126,128-255

syn keyword nilTodo contained TODO FIXME HACK XXX
syn match nilTodo contained "\<\%(TODO\|FIXME\|HACK\|XXX\)\%(\>\|:\@=\)"

syn match  nilLineComment '\\.*$' contains=@Spell,nilTodo
syn region nilComment start='(' end=')' contains=@Spell,nilTodo
syn region nilArgList start='\[' end='\]'
syn region nilCharacter start='\'' end='\'' 
syn region nilString start='"' end='"'

syn keyword nilMath  BASE BIN DEC OCT HEX
syn match   nilInteger '\<-\=\d\+\.\=\>'
syn match   nilInteger '\<#-\=\d\+\.\=\>'
syn match   nilInteger '\<\$-\=\x\+\.\=\>'
syn match   nilInteger '\<%-\=[01]\+\.\=\>'

syntax keyword nilStack drop dup over swap rot nip tuck .
syntax keyword nilBlock begin word end
syntax keyword nilConditional if else 
syntax keyword nilRepeat repeat
syntax keyword nilFunction emit .s dump
syntax keyword nilControl return break continue exit throw
syntax keyword nilOperator and or xor not + - * / < <= == != >= >
syntax keyword nilMemory here unused cell aligned @ ! 2@ 2! c@ c!
syntax keyword nilDictionary var pair create 

hi def link nilTodo Todo

hi def link nilLineComment Comment
hi def link nilComment Comment
hi def link nilArgList PreProc
hi def link nilCharacter Character
hi def link nilString String

hi def link nilMath Number
hi def link nilInteger Number

hi def link nilStack Type
hi def link nilBlock Keyword
hi def link nilConditional Conditional
hi def link nilRepeat Repeat
hi def link nilFunction Function
hi def link nilControl Exception
hi def link nilOperator Operator
hi def link nilMemory Function
hi def link nilDictionary Keyword


let &cpo=s:cpo_save
unlet s:cpo_save
