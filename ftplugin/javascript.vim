
setl autoindent
setl smartindent cinwords=if,elseif,else,for,while,try,except,finally,function,class
setl tabstop=4 expandtab shiftwidth=4 softtabstop=4

"nnoremap <F4> :w<CR>:make<CR>:cw<CR>
nnoremap <F4> :w<CR>:make<CR>:copen<CR>

setlocal makeprg=jshint\ %
" setlocal errorformat=%-P%f,
"                     \%-G/*jslint\ %.%#*/,
"                     \%*[\ ]%n\ %l\\,%c:\ %m,
"                     \%-G\ \ \ \ %.%#,
"                     \%-GNo\ errors\ found.,
"                     \%-Q

