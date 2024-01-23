set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Plugin 'Vallroic/YouCompleteMe'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'nvie/vim-flake8'
Plugin 'dense-analysis/ale'
Plugin 'kristijanhusak/vim-carbon-now-sh'
Plugin 'github/copilot.vim'
Plugin 'NoahTheDuke/vim-just'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"let g:syntastic_python_checkers = ['flake8']
let g:ale_linters = { "python": ["ruff"] }
let g:ale_fixers = {
\       "python": ["black", "ruff"],
\}

let python_highlight_all=1
syntax on


"if &diff
"    colorscheme gruvbox
"endif

let g:virtualenv_auto_activate = 1
"let g:black_linelength = 79

cab black !black %
cab evince !evince %<.pdf &
cab latex !(latex -shell-escape %< && bibtex %< && latex -shell-escape %< && latex -shell-escape %<)
cab notabs %s/	/    /g
cab pdflatex !(pdflatex %< && bibtex %< && pdflatex %< && pdflatex %<)
cab ru term cargo run
cab xdvi !xdvi %<.dvi &
cab xpdf !xpdf %<.pdf &
iab bargparse import argparseparser = argparse.ArgumentParser()parser.add_argument('arg', help='First arg')parser.add_argument('--opt', help='First opt')parser.add_argument('--flag', action='store_true', help='Set flag true')args = parser.parse_args()
iab bargs """Arguments::param foo: what is foo:type foo: footype:returns: what is bar:rtype: bartype"""
iab bart \documentclass{article}\begin{document}\end{document}O
iab bdiv <div class="col-md-6"></div>O
iab bdoc \begin{document}\end{document}O
iab beq \begin{equation}\end{equation}O
iab bhtml <!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title></title><script></script></head><body></body></html>
iab biff {% if lang == "en" %}{% else %}{% endif %}
iab bmain if __name__ == "__main__":
iab bmark @pytest.mark.parametrize('input, expected',[(),])
iab bmint \begin{minted}[bgcolor=bgcode]{Python}\end{minted}O
iab bminted \begin{minted}[bgcolor=lightgray]{python}\end{minted}O
iab bpy #!/usr/bin/env python# -*- coding: utf-8 -*-
iab brevtex \documentclass{revtex4}\begin{document}\end{document}O
iab brow <div class="row"></div>O
iab bsp \begin{split}\end{split}O
iab bunittest import unittestclass NewTest(unittest.TestCase):    def setUp(self):        pass    def tearDown(self):        passif __name__ == "__main__":    unittest.main()
iab dtsk # doctest: +SKIP
iab dtws # doctest: +NORMALIZE_WHITESPACE
    

"set efm=%f:%l.%c:%m
"set efm=%A%f:%l.%c:,%C,%C\ %.%#,%ZError:\ %m,%ZWarning:\ %m,%f:(%.%#):%m
"set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"set efm=%EE\ %m,%C,%C%f:%l:%.%#,%Z
"set efm=%EE\ %m,%C,%Z%f:%l:%.%#
"set efm=E\ %.%#File\ \"%f\"\\,\ line\ %l
set efm=%E%f:%l:%c:,%C,%C%m,%Z%m

set makeprg=make
setlocal spell spelllang=en_us
set ts=88
au BufNewFile,BufRead * set sw=4 tw=79
au BufNewFile,BufRead *.F set sw=3 tw=72
au BufNewFile,BufRead [Mm]akefile set ts=8
au BufNewFile,BufRead *.mk set ts=8
au BufNewFile,BufRead *.cpp set ts=4
au BufNewFile,BufRead *.h set ts=4


" split
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

hi clear SpellCap
hi SpellCap ctermbg=yellow

hi clear SpellLocal
hi SpellLocal cterm=undercurl ctermfg=blue

hi clear SpellRare
hi SpellLocal cterm=underline ctermfg=darkgreen

"au BufWritePost *.py !python -m pytest -vx
au BufWritePost *.py !test -f tests/test_% && python -m pytest -x  tests/test_% || :
au BufWritePost lib.rs !maturin develop
au BufWritePost main.rs !cargo run
"au BufWritePost test_*.py !python -m pytest -vvx %
"au BufWritePost test_*.py vnew
"au BufWritePost *.md !python -m pytest --doctest-glob="*.md" %
"au BufWritePost *.md !make test
"au BufWritePost *.py !python -m nose -x
au BufWritePost *.tex !make $(basename % .tex).pdf
":map  "zyiw:!python -m pytest ".@z.""<CR>
" With the cursur over the test function name, run this with pytest
":map  mx?def w"zyiw:exe "!python -m pytest -v -k ".@z." %"<CR>
":map  mx?def w"zyiw:exe "!python -m pytest -v -k ".@z." "<CR>
":nmap ; mx?def w"zyiw:!python -m pytest --pdb -vx -k z %
:nmap ;T mx?class w"zyiw:term python3 -m pytest --pdb -vvx -k z %
:nmap ;t mx?def w"zyiw:term python3 -m pytest --pdb -vvx -k z %
:nmap ;v mx?def w"zyiw:vert term python3 -m pytest --pdb -vvx -k z %
:nmap ;s mx?def w"zyiw:term python3 -m pytest --pdb -svx -k z %
:nmap ,vt :vert term python3 -m pytest --pdb -vv %
:nmap ,a :term python3 -im app
:nmap ,r :term python3 -i %
:nmap ,s :term python3 -m pytest --pdb -vs %
:nmap ,t :term python3 -m pytest --pdb -vv %
:nmap ,d :term python3 -m pdb %
:nmap ,v :vert term python3 -i %
:nmap ,dt :term python3 -m doctest %

:nmap ,c :!python -m pytest --pdb -v --cov --cov-report=html; python3 -c 'import webbrowser; webbrowser.open_new_tab("http://localhost:8000")'; (cd htmlcov && python3 -m http.server) 
:map \ mx?def w"zyiw:new:read !python -m pytest -x -v -k z #
":map  mx?def w"zyiw:vnew:read !python -m pytest -s -x -v -k z #
":map  :only!:vert term:0read !python3 #
"cmap ru new:0read !python3 #
":map  :!gnome-terminal -- python3 -i %


:cnoremap pip !python -m pip 


autocmd FileType python map <buffer> ,f :call Flake8()<CR>
"nmap cp :ConqueTermVSplit python3<CR>

inoremap <ul> <ul></ul>O
inoremap <li> <li></li>hhhhi
inoremap <p> <p></p>hhhi
inoremap <form> <form></form>O

set vb
