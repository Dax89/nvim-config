if exists('b:did_ftplugin')
  finish
endif

let s:cpo_save=&cpo
set cpo&vim

let b:did_ftplugin=1
let b:match_ignorecase=1

setlocal commentstring=\\\ %s
setlocal comments=s:(,mb:\ ,e:),b:\\

let &cpo=s:cpo_save
unlet s:cpo_save
