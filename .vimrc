set fileencodings=utf-8,cp1251
set nu
set iminsert=0
set ic
set hls
set autoindent
"syntax on

" PEP-8 soft tabs, width 4, and folding
"set foldenable
"set foldmethod=indent
set ai ts=4 sts=4 et sw=4

" Set russian-specific keywords regexp
set iskeyword=@,48-57,_,192-255

function! BufNewFile_PY()
0put = '#!/usr/bin/env python'
1put = '#-*- coding: utf-8 -*-'
2put = ''
normal G
endfunction
autocmd BufNewFile *.py call BufNewFile_PY()
autocmd BufNewFile *.pyw call BufNewFile_PY()

" Auto brackets
imap [ []<LEFT>
imap ( ()<LEFT>
imap { {}<LEFT>

" Related-files jump for django
let g:last_relative_dir = ''
nnoremap \m :call RelatedFile ("models.py")<cr>
nnoremap \v :call RelatedFile ("views.py")<cr>
nnoremap \u :call RelatedFile ("urls.py")<cr>
nnoremap \a :call RelatedFile ("admin.py")<cr>
nnoremap \t :call RelatedFile ("tests.py")<cr>
nnoremap \1 :call RelatedFile ( "templates/" )<cr>
nnoremap \2 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \3 :call RelatedFile ( "management/" )<cr>
nnoremap \s :e settings.py<cr>
nnoremap \uu :e urls.py<cr>

fun! RelatedFile(file)
    "This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()

" Enable snippets


" Color theme
set t_Co=256
colorscheme neverland2-darker
syntax enable

" Highlign brakets
highlight MatchParen cterm=bold ctermfg=white

" No swp files
set noswapfile
" Enable snippets
filetype plugin on
