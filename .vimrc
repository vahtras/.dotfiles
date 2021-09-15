if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'jmcantrell/vim-virtualenv'
"Plug 'psf/black'
Plug 'liuchengxu/vim-clap'
Plug 'morhetz/gruvbox'
"Plug 'numirias/semshi'
Plug 'vimwiki/vimwiki'
Plug 'pychimp/vim-sol'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()

if &diff
    colorscheme gruvbox
endif

let g:virtualenv_auto_activate = 1
"let g:black_linelength = 79

cab latex !(latex -shell-escape %< && bibtex %< && latex -shell-escape %< && latex -shell-escape %<)
cab xdvi !xdvi %<.dvi &
cab pdflatex !(pdflatex %< && bibtex %< && pdflatex %< && pdflatex %<)
cab xpdf !xpdf %<.pdf &
cab evince !evince %<.pdf &
iab bart \documentclass{article}\begin{document}\end{document}O
cab black !black %
cab notabs %s/	/    /g
iab brevtex \documentclass{revtex4}\begin{document}\end{document}O
iab bhtml <!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title></title><script></script></head><body></body></html>
iab bdiv <div class="col-md-6"></div>O
iab bmint \begin{minted}[bgcolor=bgcode]{Python}\end{minted}O
iab brow <div class="row"></div>O
iab bdoc \begin{document}\end{document}O
iab beq \begin{equation}\end{equation}O
iab bmain if __name__ == "__main__":
iab bminted \begin{minted}[bgcolor=lightgray]{python}\end{minted}O
iab bmark @pytest.mark.parametrize('input, expected',[(),])
iab bsp \begin{split}\end{split}O
iab bpy #!/usr/bin/env python# -*- coding: utf-8 -*-
iab bunittest import unittestclass NewTest(unittest.TestCase):    def setUp(self):        pass    def tearDown(self):        passif __name__ == "__main__":    unittest.main()
iab bargparse import argparseparser = argparse.ArgumentParser()parser.add_argument('arg', help='First arg')parser.add_argument('--opt', help='First opt')parser.add_argument('--flag', action='store_true', help='Set flag true')args = parser.parse_args()
iab bargs """Arguments::param foo: what is foo:type foo: footype:returns: what is bar:rtype: bartype"""
    

"set efm=%f:%l.%c:%m
"set efm=%A%f:%l.%c:,%C,%C\ %.%#,%ZError:\ %m,%ZWarning:\ %m,%f:(%.%#):%m
"set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"set efm=%EE\ %m,%C,%C%f:%l:%.%#,%Z
"set efm=%EE\ %m,%C,%Z%f:%l:%.%#
set efm=E\ %.%#File\ \"%f\"\\,\ line\ %l

set makeprg=make
setlocal spell spelllang=en_us
set ts=88
au BufNewFile,BufRead * set sw=4 tw=79
au BufNewFile,BufRead *.F set sw=3 tw=72
au BufNewFile,BufRead [Mm]akefile set ts=8
au BufNewFile,BufRead *.mk set ts=8
au BufNewFile,BufRead *.cpp set ts=4
au BufNewFile,BufRead *.h set ts=4

syntax on

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
"au BufWritePost test_*.py !python -m pytest -vvx %
"au BufWritePost test_*.py vnew
"au BufWritePost *.md !python -m pytest --doctest-glob="*.md" %
"au BufWritePost *.md !make test
"au BufWritePost *.py !python -m nose -x
au BufWritePost *.tex !make
":map  "zyiw:!python -m pytest ".@z.""<CR>
" With the cursur over the test function name, run this with pytest
":map  mx?def w"zyiw:exe "!python -m pytest -v -k ".@z." %"<CR>
":map  mx?def w"zyiw:exe "!python -m pytest -v -k ".@z." "<CR>
":nmap ; mx?def w"zyiw:!python -m pytest --pdb -vx -k z %
:nmap ;T mx?class w"zyiw:term python3 -m pytest --pdb -vvx -k z %
:nmap ;t mx?def w"zyiw:term python3 -m pytest --pdb -vvx -k z %
:nmap ;v mx?def w"zyiw:vert term python3 -m pytest --pdb -vvx -k z %
:nmap ;s mx?def w"zyiw:term python3 -m pytest --pdb -svx -k z %
:nmap ,t :term python3 -m pytest --pdb -v %
:nmap ,vt :vert term python3 -m pytest --pdb -v %
:nmap ,s :term python3 -m pytest --pdb -vs %
:nmap ,r :term python3 -i %
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

set efm=%f:%l:\ DocTestFailure

imap aa å
imap ae ä
imap oe ő

