alias bal='vim ~/.dotfiles/.bash_aliases'
alias brc='vim ~/.dotfiles/.bashrc'
alias cdl='cd "$(ls -td */ | head -1)"'
alias cddal='cd ~/dev/dalton && cd build/$(git w)'
alias chill='pip-chill --no-chill | grep -v pytest | grep -v selenium | grep -v httpx'
alias dtags='ctags ../../DALTON/*/*.[Fhc]'
alias dl='mv -v "$HOME/Downloads/$(ls -t ~/Downloads|head -1)" .'
alias evincel='evince "$(ls -t *.pdf| head -1)"'
alias glances='glances --theme-white'
alias glink='sed "s;file/d/;uc?id=;" | sed "s;/view.*;;"'
alias nb='python -m notebook'
alias maked='make -f flask-deploy/Makefile'
alias newslide='cookiecutter cookiecutter-slides'
alias taif='tail -f $(ls -t | head -1)'
alias kindle='open https://read.amazon.com/notebook'
alias lsl='ls -lth | head'
alias lsh='ls --hyperlink=auto'
# alias vil='vim "$(ls -t | head -1)"'
alias openl='xdg-open "$(ls -t | head -1)"'
alias pip='PIP_FORMAT=columns uv pip'
alias pup='pip install pip setuptools wheel --upgrade'
alias piplist='pip-chill --no-chill'
alias pyl='python $(ls -t | head -1)'
alias pytest='python3 -m pytest'
alias R='R --no-restore --no-save'
alias randomhex='python3 -c "import uuid; print(uuid.uuid4().hex)"'
alias tree='tree -I "venv*|__pycache__"'
alias tmpdir='cd $(mktemp -d)'
alias tmpenv='condaenv=$(basename $(mktemp -u))-${PYTHON-3.7} && conda create -y -c conda-forge -n $condaenv python=${PYTHON-3.7} && conda activate $condaenv'
alias vrc='vim ~/.vimrc'
# alias vlx='python -m veloxchem'
alias x='xsel -b'
alias open='xdg-open'
alias xpdfl='xpdf "$(ls -t *.pdf| head -1)"'
alias xviewl='xview "$(ls -t *.png| head -1)"'
alias condainit='eval "$(~/miniconda/condabin/conda  shell.bash hook)"'
alias nbgraderinit='jupyter nbextension install --sys-prefix --py nbgrader --overwrite; jupyter nbextension enable --sys-prefix --py nbgrader; jupyter serverextension enable --sys-prefix --py nbgrader'

function gdl {
    gdown $(echo $1 | glink)
}

function vil {
    echo 'ho'
    vim "$(ls -t *$1 | head -1)"
}

function findgrep {
re_dir=$1
re_file=$2
re_pattern=$3
find $re_dir -name "$re_file" -exec grep -H $re_pattern {} \;
}

function pycal {
arg=`echo  $1 | sed 's/D/E/g' | sed 's/d/e/g'`
python3 -c "from math import *; print($arg)"
}

function Kinit {
kdestroy
kinit -l 30d vahtras
}

function Kume {
kdestroy
kinit -l 30d vahtras@HPC2N.UMU.SE
}

function Kadmin {
export KRBTKFILE=/tmp/tktvahtras2admin
export KRB5CCNAME=/tmp/krb5cc_vahtras2admin
echo Picked KRB5CCNAME $KRB5CCNAME
echo Picked KRBTKFILE $KRBTKFILE
klist -t || kinit -l 3h --no-forwardable vahtras/admin@NADA.KTH.SE
}

function Kroot {
export KRBTKFILE=/tmp/tktvahtras2root
export KRB5CCNAME=/tmp/krb5cc_vahtras2root
echo Picked KRB5CCNAME $KRB5CCNAME
echo Picked KRBTKFILE $KRBTKFILE
klist -t || kinit -l 3h --no-forwardable vahtras/root@NADA.KTH.SE
}

function ferlin-nodes {
nodes=$(ssh -X vahtras@ferlin.pdc.kth.se /pdc/vol/easy/1.8.ferlin/bin/spusage | grep $1 | awk '{print $1}')
for i in $nodes; do ssh -f -X vahtras@$i xterm -T $i; done
}

function ferlin-nodes-cmd {
nodes=$(ssh -X vahtras@ferlin.pdc.kth.se /pdc/vol/easy/1.8.ferlin/bin/spusage | grep $1 | awk '{print $1}')
for i in $nodes; do ssh -f -X vahtras@$i "hostname; $2" ; done
}

function ekman-nodes {
nodes=$(ssh -X vahtras@ekman.pdc.kth.se /pdc/vol/easy/1.8.ekman/bin/spusage | grep $1 | awk '{print $1}')
for i in $nodes; do ssh -f -X vahtras@$i xterm -T $i; done
}

function grepl {
grep $1 $(/bin/ls -t | head -1)
}

function sshx {
klist -t || kinit vahtras
ssh -f -X vahtras@$1.pdc.kth.se xterm -T $1
}

function dalexe {
    env BASDIR=/opt/dalton/basis /opt/dalton/bin/dalton.x
}

function dalbranch {
branch=$1; shift
~/dev/dalton/build/$branch/dalton -ext $branch.out $@
}

function rem {
cat | mutt -s $1 of
}

function focus {
gsettings set org.gnome.desktop.wm.preferences focus-mode "$1"
}

function mvln {
if [ -f $1 -a -d $2 ]; then
mv -v $1 $2
ln -vs $2/$1 .
else
test -f $1 || echo "No file $1"
test -d $2 || echo "No dir $2"
return 1
fi
}

function mvswap {
if [ -f $1 -a -f $2 ]; then
mv -v $1 /tmp/$1.$$
mv -v $2 $1
mv -v /tmp/$1.$$ $2
fi
}

function mvall {
for i in $(ls *$1* 2> /dev/null)
do
   new=$(echo "$i"  | sed "s/$1/$2/g")
   echo $PRE mv "$i" "$new"
   $PRE mv "$i" "$new"
done
}

function cpall {
for i in $(ls *$1* 2> /dev/null)
do
   new=$(echo $i  | sed "s/$1/$2/g")
   echo "cp $i $new"
   cp $i $new
done
}

function dtest {
testsuite="dummy"
for i in $(grep -l $1 ../../DALTON/test/rsp*|sed "s/.*test\///"); do testsuite="$testsuite|^$i$"; done
echo $testsuite
ctest -R "$testsuite"
}

function heroku_init {
proj=$1
loc=${2-djangobs} #Define local directory to store djangobs repo
log=/tmp/$proj.log

mkdir $proj && cd $proj
echo "Starting project $proj" | tee $log

APPENDLOG="tee -a $log"

echo "Making virtual environment $proj" | $APPENDLOG
workon $proj 2> /dev/null || mkvirtualenv $proj >> $log
# This installs pip locally, upgrade to latest
pip install --upgrade pip | $APPENDLOG

echo "Install django" | $APPENDLOG
pip install django-toolbelt  >> $log

echo "Start django" | $APPENDLOG
django-admin.py startproject $proj . >> $log

echo "Generate Procfile" | $APPENDLOG
cat > Procfile << EOF
web: gunicorn $proj.wsgi
EOF

echo "Generate requirements.txt" | $APPENDLOG
pip freeze > requirements.txt
#cat requirements.txt

echo "Update $proj/settings.py" | $APPENDLOG
cat >> $proj/settings.py <<EOF
######### HEROKU ###############
# Parse database configuration from $DATABASE_URL
import dj_database_url
DATABASES['default'] =  dj_database_url.config()

# Honor the 'X-Forwarded-Proto' header for request.is_secure()
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

# Allow all host headers
ALLOWED_HOSTS = ['*']

# Static asset configuration
import os
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
STATIC_ROOT = 'staticfiles'
STATIC_URL = '/static/'

STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
    ) + STATICFILES_DIRS
#################################
TEMPLATE_DIRS = (
    os.path.join(BASE_DIR, 'html'),
    ) + TEMPLATE_DIRS
ROOT_URLCONF = '$loc.urls'
EOF

echo "Update $proj/wsgi.py" | $APPENDLOG
cat >> $proj/wsgi.py <<EOF
###### HEROKU ############
from django.core.wsgi import get_wsgi_application
from dj_static import Cling

application = Cling(get_wsgi_application())
##########################
EOF


#
# A project home.html
#

echo "Generate $proj/html/home.html" | $APPENDLOG
mkdir $proj/html/
cat >> $proj/html/home.html << EOF
{% extends "base.html" %}
{% block banner %}
<h1> $proj </h1>
{% endblock %}
EOF



echo "Git int" | $APPENDLOG
git init >> $log
echo '*.pyc' > .gitignore
echo "Git add" | $APPENDLOG
git add .
echo "Git commit" | $APPENDLOG
git commit -m "git:Initialize $proj" >> $log
echo "gitsubtree_init:" | $APPENDLOG
gitsubtree_init ~/Dropbox/git/djangobs.git djangobs  >> $log

#
# Final touches: A home page object
#

echo "Modify $proj/__init__.py" | $APPENDLOG
cat >> $proj/__init__.py << EOF
# -*- coding: utf-8 -*-
from $loc.hp import HomePage
pages = (
    HomePage("", "Start"),
    )
EOF
git add $proj/__init__.py
#
#
# Modify settings to import from base
#
#
echo "Modify $proj/settings.py" | $APPENDLOG 
echo "from $loc.settings.base import *" | cat - $proj/settings.py > /tmp/settings.py
cp /tmp/settings.py $proj/
git add $proj/settings.py

#
# Commit
#
echo "Commit" | $APPENDLOG 
git commit -m "My $proj app" >> $log
#
#
# Local test
#
#
python manage.py shell && python manage.py runserver
#
}

function heroku_deploy {
proj=$1
log=/tmp/$proj.log
LOG="tee -a $log"
echo "Deploy $proj" | $LOG
#
# Depoly on heroku
#

heroku create 2>&1 | $LOG
git push heroku master 2>&1 | $LOG

heroku config:set DJANGO_SETTINGS_MODULE=$proj.settings | $LOG
heroku ps:scale web=1 | $LOG
heroku ps | $LOG
heroku open | $LOG
}

function merge_proj_to_subdir {
repo=$1
subproj=$(basename $repo .git)
subdir=${2-$subproj}

git remote add -f $subproj $repo
git merge --squash -s ours --no-commit $subproj/master
git read-tree --prefix=$subdir/ -u $subproj/master
git commit -m "Merge Project $subproj to $subdir"
}

function merge_proj_submodule_to_subdir {
repo=$1
subproj=$(basename $repo .git)
submodule=$2
subdir=${3-$submodule}

git remote add -f $subproj $repo
git merge --squash -s ours --no-commit $subproj/master
git read-tree --prefix=$subdir/ -u $subproj/master:$submodule
git commit -m "Merge Project $subproj to $subdir"
}

function gitsubtree_init {
remote_name=$1
remote_repo=$2 
git remote add -f $remote_name $remote_repo
git checkout -b $remote_name ${remote_name}/master
git checkout master
git read-tree --prefix=${remote_name}/ -u ${remote_name}
git commit -m "Add ${remote_name} as subtree"
}

function gitinit {
git init .
touch .gitignore
git add .gitignore
git commit -m init
}

function gitsubtree_update {
repo=$1; remote_proj=remote/$(basename $repo .git)
remote_sub=${2-$1}
git checkout $remote_proj
git fetch $remote_proj
git rebase $remote_proj/master
git subtree split --prefix=$remote_sub -b subtrees/$remote_sub
git checkout master
git subtree merge --prefix=$remote_sub --squash subtrees/$remote_sub
}

function makedropboxrepo {
remotename=${1-dropbox}
localbranch=$(git symbolic-ref --short HEAD)
root=$(basename $PWD)
repo=~/Dropbox/git/$root.git
git init --bare $repo
git remote add $remotename $repo
git push -u $remotename $localbranch
}

function makeonedriverepo {
remotename=${1-onedrive}
localbranch=$(git symbolic-ref --short HEAD)
root=$(basename $PWD)
repo=~/OneDrive/git/$root.git
git init --bare $repo
git remote add $remotename $repo
git push -u $remotename $localbranch
}

function subinfiles {
perl -pi -e "s,$1,$2,g" `find . -name $3 -print`
}

alias whichbranch='git symbolic-ref --short HEAD'

function poppath {
$(python -c 'import os; print "export PATH=%s" % ":".join(os.environ["PATH"].split(":")[1:])')
}

function energies {
env PYTHONPATH=~/dev/py python -m dalmisc.scan_dalton --energy $@ | sort -nr -k 2
}

github-create() {
  repo_name=${1-$(basename $(pwd))}
  branch_name=${2-"master"}

  invalid_credentials=0
  username=vahtras
  token=`cat ~/.github`

  if [ "$token" = "" ]; then
    echo "  Could not find token, save token in ~/.github"
    invalid_credentials=1
  fi

  if [ "$invalid_credentials" -eq "1" ]; then
    echo "Invalid credentials"
    return 1
  fi

  echo -n "  Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
  echo " done."

  #echo -n "  Pushing local code to remote ..."
  git remote add github git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u github $branch_name-pages > /dev/null 2>&1
  echo " done."
}


function github-pages {
git checkout -b gh-pages
git push -u github gh-pages
}


function sc_new_lesson {
    test -n "$1" && lesson=$1 || (echo "Usage: sc_new_lesson <lesson>")

    #1. Create an empty repository on GitHub
    curl -u "$(git config github.user):$(git config github.token)" https://api.github.com/user/repos -d '{"name":"'$lesson'"}' 

    #2. Clone the template repository to your computer
    git clone -b gh-pages -o upstream https://github.com/swcarpentry/lesson-template.git $lesson


    #3. Go into that directory
    cd $lesson

    #4. Add your GitHub repository as a remote
    git remote add origin git@github.com:$(git config github.user)/$lesson

    #5. Edit files...

    #6. Build HTML
    cd pages
    make preview

    #7 Commit changes
    cd ..
    git add -u
    git add *.html
    git commit
    git push origin gh-pages
    
}


function dalgrep_energy {
    PYTHONPATH=~/dev/py python -m dalmisc.scan_dalton  --energy --fmt="%20.6f" $* | sort -k 2 
}
function dalgrep_ci {
    PYTHONPATH=~/dev/py python -m dalmisc.scan_dalton  --ci-energies --fmt="%14.6f" $* | sort -k 2 
}

function newcss {
cat > talk.css << EOF
<style>
.centered {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
</style>
<link rel="stylesheet" href="/$talk/refreeze/js/highlight/styles/gruvbox-light.css">
<script src="/$talk/refreeze/js/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
EOF
}

function newmd {
    cat > talk.md << EOF
# $talk

## h2

### h3

titlepage

---

layout: false

## Write me

- Hi
- Ho

\$$ E = mc^2 \$$

~~~
>>> foo = "bar"
>>> foo
'bar'

~~~

---

## Slide

- Write me
EOF
}
function dotgitignore {
    cat >> .gitignore << EOF
*.pyc
EOF
}

function dotgithooks {
    cat >> .git/hooks/pre-commit << EOF
#!/bin/bash
make test || exit 1
make && git add index.html
EOF
    chmod +x .git/hooks/pre-commit
}
function openstatic {
    cat > open_static.py << EOF
#!/usr/bin/env python

import flask
import random

root = '$PWD'
app = flask.Flask(__name__, static_folder=root, static_url_path='/$talk', template_folder=root)


@app.route('/')
def index():
    return flask.render_template('index.html')


port = int(5000 + 5000*random.random())
app.run(debug=True, port=port)
EOF
}

function newmake {
    cat > Makefile << EOF
index.html: talk.md talk.css
	python refreeze/freeze.py
	@cp index.html /tmp
	@cat /tmp/index.html | sed "s;img/;/$talk/img/;" > index.html
	vim -s script index.html

test:
	python -m doctest talk.md

pytest:
	python -m pytest -vx --doctest-glob '*.md'

RANDOM_PORT=\`python -c 'import random; print(int(5000+ 5000*random.random()))'\`

slideshow:
	PORT=\$(RANDOM_PORT) python refreeze/flask_app.py &
show:
	python refreeze/open_static.py
EOF
    cat > script <<EOF
:%s/\#doctest.*//:wq
EOF
}

function newtalk {
    test "$1" != "" || (echo "Usage: newtalk <topic>"; return 1) || return 1
    talk=$1
    mkdir $talk && cd $talk
    newcss
    newmd

    git init
    git checkout -b gh-pages
    dotgitignore
    dotgithooks
    openstatic
    newmake


    newvenv talk-$talk 
    uv pip install setuptools Frozen-Flask pytest pip-chill
    pip-chill > requirements.txt
    git submodule add https://github.com/vahtras/refreeze.git refreeze
    python refreeze/freeze.py

    make
    git add talk.md talk.css index.html open_static.py .gitignore requirements.txt index.html Makefile
    git commit -m "initial commit"
}       


function pyver {
    python3 -c 'import sys; print(f"{sys.version_info.major}{sys.version_info.minor}")'
}

function venv {
venv=.venv$(pyver)
python3 -m venv $venv --prompt "$(basename $PWD)-$(pyver)"
. $venv/bin/activate
python3 -m pip install --upgrade pip $@
python3 -m pip install wheel
test -r requirements-dev.txt && python3 -m pip install -r requirements-dev.txt 
test -r requirements-dev.txt || test -r requirements.txt && python3 -m pip install -r requirements.txt 
}


function venv {
ver=${1-3.8}
python$ver -m venv venv/$ver
source venv/$ver/bin/activate
python$ver -m pip install pip wheel --upgrade 
usemkl
if [[ "$2" == "install" ]]; then
    test -r requirements.txt && pip install -r requirements.txt
fi
}

function usemkl {
    export MKLROOT=/opt/intel/mkl
    export LD_LIBRARY_PATH=$MKLROOT/lib/intel64
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
    export GTESTROOT=/usr/local
}

alias intel='. /opt/intel/bin/ifortvars.sh intel64; . /opt/intel/inspector_xe/inspxe-vars.sh; .  /opt/intel/debugger_2016/bin/debuggervars.sh'

alias purge='mv -v *.[0-9] /tmp'

alias intelpy2='. /opt/intel/intelpython27/bin/pythonvars.sh'
alias intelpy3='. /opt/intel/intelpython35/bin/pythonvars.sh'
findall () 
{ 
    find ${2-.} -type f -exec grep -H $1 {} \;
}

catcsv () { python -c "import pandas; print(pandas.read_csv('$1', sep='${2-,}'))" ;}


function makelecture {
test "$1" != "" || exit
talk=$1
mkdir $talk && cd $talk && cat > talk.md << EOF
<script type="text/javascript"
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
# $talk

## 

BB1000 Programming in Python
KTH

---

layout: false

## First slide

- write
- me

EOF

    git init
    echo venv > .gitignore
    python3 -m venv venv
    . venv/bin/activate
    pip install Flask
    pip install Frozen-Flask
    pip freeze > requirements.txt
    git submodule add https://github.com/rbast/refreeze.git refreeze
    python refreeze/freeze.py
    cat > Makefile << EOF
index.html: talk.md
	python refreeze/freeze.py

test:
	python -m doctest talk.md

RANDOM_PORT=\`python -c 'import random; print(int(5000+ 5000*random.random()))'\`

slideshow:
	PORT=\$(RANDOM_PORT) python refreeze/flask_app.py
EOF
    git add talk.md  .gitignore requirements.txt index.html Makefile
    git commit -m "initial commit"
}       

function www {
python3 -c 'import webbrowser; webbrowser.open_new_tab("http://localhost:8000")'
(cd "$1" && python3 -m http.server)
}

function ip {
ifconfig $1 | grep -w inet | python3 -c 'print(input().split()[1])'
}

function vlxsetup {
cat config/Setup.Ubuntu.Gnu | sed s'@^GST_ROOT.*@GST_ROOT := /opt/googletest/googletest@' | sed s'@^PYBIND11_ROOT.*@PYBIND11_ROOT := /opt/pybind11@' > src/Makefile.setup
export MKLROOT=/opt/intel/mkl PYBIND11_ROOT=/opt/pybind11 PYTHONPATH=$(pwd)/build/python 
python3 -m venv venv.$(basename $(pwd))
source venv.$(basename $(pwd))/bin/activate
pip3 install -r requirements.txt
}

function besta1 {
a=$1
g=$2
# c=$3
shift; shift
set -x
# boxplot --cat Skola --filters ArbOmr=$a Grupp.nivå=$g --table 0 $*
boxplot --cat Skola --filters Arbetsområde=$a Grupperingsnivå=$g $*
set +x
}

function besta2 {
a=$1
g=$2
# c=$3
shift; shift
pointplot --cat Kön --table 0 --filters Arbetsområde=$a Grupperingsnivå=$g  $*
}

function bef {
bef=$1; shift
#boxplot --cat Skola --filters Benämning=$bef --table 0 $*
boxplot --cat Skola --filters Benämning=$bef $*
# boxplot --filters Benämning=$bef $*
}

function bef-kth {
bef=$1; shift
#boxplot --cat Skola --filters Benämning=$bef --table 0 $*
# boxplot --cat Skola --filters Benämning=$bef $*
boxplot --filters Benämning=$bef $*
}

function ppbef {
bef=$1; shift
pointplot --cat Kön --filters Benämning=$bef $*
}

function efternamn {
    boxplot --show Efternamn=$1
}

function cv {
    cd $1
    test -d .venv && source .venv/bin/activate
}

function activate {
    test -d $1/.venv && source $1/.venv/bin/activate
}

function cov {
    pytest $1 --cov=$(basename $2 .py) --cov-report=term-missing --cov-report=html
}
function mut {
    mut.py --unit-test=$(basename $1 .py) --target=$(basename $2 .py) --runner pytest -m
}

function newcourse {
    course_id=$1
    pyenv virtualenv $course_id
    venvdir=~/.pyenv/versions/$course_id
    bindir=$venvdir/bin
    $bindir/python -m pip install pip --upgrade
    uv pip install setuptools wheel --upgrade
    uv pip install jupyterlab-vim jupyter_contrib_nbextensions jupyter_nbextensions_configurator nbgrader

    $bindir/nbgrader quickstart $course_id && \
    cat << EOF >> $course_id/nbgrader_config.py
c.FileNameCollectorPlugin.named_regexp = \
    r'.*\w+_(?P<student_id>\d+)_(?P<submission_id>\d+)_(?P<file_id>.*)'
c.ClearSolutions.code_stub = {'python': '# YOUR CODE HERE\n################', 'matlab': "% YOUR CODE HERE\nerror('No Answer Given!')", 'octave': "% YOUR CODE HERE\nerror('No Answer Given!')", 'sas': '/* YOUR CODE HERE */\n %notImplemented;', 'java': '// YOUR CODE HERE'}
c.Exchange.root = '/srv/nbgrader/exchange'
EOF
    echo "export COURSE=$course_id" >> .envrc
    echo "export COURSE=$course_id" > .envrc
    direnv allow
    pyenv local $course_id
}

function newvenv {
    venv=$1 && shift 
    pyenv virtualenv $venv
    pyenv local $venv
    source ~/.pyenv/versions/$venv
}

function envrc {
    venvdir=~/.venvs/${1-${PWD:t}}
    echo "source $venvdir/bin/activate" > .envrc
    echo "unset PS1" >> .envrc
    direnv allow
}

function newpkg {
    echo "#!/usr/bin/env/pythonfrom setuptools import setupsetup()" > setup.py
    pkg=$1
    cat > setup.cfg << EOF
[metadata]
name = $pkg
description-file = README.md
version = attr: $pkg.__version__
author = Olav Vahtras
author_email = vahtras@kth.se
license = GPLv3
license_file = LICENSE
description = $pkg: DESCRIBE ME
long_description = file: README.md
long_description_content_type = text/markdown
url = https://github.com/vahtras/$pkg
classifiers =
    Development Status :: 5 - Production/Stable
    Intended Audience :: Science/Research
    License :: OSI Approved :: GNU General Public License v3 (GPLv3)
    Programming Language :: Python
    Programming Language :: Python :: 3
    Programming Language :: Python :: 3.7
    Programming Language :: Python :: 3.8
    Programming Language :: Python :: 3.9
    Programming Language :: Python :: 3.10
    Topic :: Scientific/Engineering :: Chemistry

[options]
packages = $pkg
python_requires > 3.6

[options.entry_points]
console_scripts =
    $pkg = $pkg.__main__:main
EOF
}


function wo {
    source ~/.venvs/$1/bin/activate
}

function path-pop {
    echo $PATH | python -c 'path=input(); print("export PATH=", path.split(":", 1)[1], sep="")'
}
function newsite {
    site=$1
    venv=~/.venvs/$site
    test -d $venv || newenv $site
    $venv/bin/python -m pip install --upgrade pip wheel
    $venv/bin/python -m pip install flask-bootstrap
    mkdir $site
    cd $site
    #
    # run script
    #
    cat > run.py << EOF
#!/usr/bin/env python

import webbrowser

import flask
import flask_bootstrap


app = flask.Flask(__name__)
flask_bootstrap.Bootstrap().init_app(app)

@app.route('/')
def index():
    return flask.render_template('index.html')

if __name__ == "__main__":
    webbrowser.open_new_tab('localhost:5000')
    app.run(debug=True)
EOF
    chmod +x run.py

    #
    # templates folder
    #
    mkdir templates
    cat > templates/index.html << EOF
{% extends "bootstrap/base.html" %}
{% block styles %}
{{ super() }}
<link rel="stylesheet" href="/static/css/styles.css">
{% endblock styles %}
{% block content %}
<div class="container">
<h1>Lorem Ipsum</h1>

<h2>"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet,
consectetur, adipisci velit..."</h2>

<h3>"There is no one who loves pain itself, who seeks after it and wants to
have it, simply because it is pain..."</h3>
<p>
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tristique iaculis ante vel egestas. Nunc vitae neque id erat feugiat luctus non ac ex. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum id purus consectetur, venenatis augue eu, mattis massa. Fusce congue massa vitae orci vehicula, varius dictum arcu mollis. Maecenas commodo nunc semper elit lacinia, egestas consequat felis hendrerit. Cras eu sagittis felis. Nullam facilisis massa ac mi posuere luctus.
</p>
</div>
{% endblock content %}
EOF

    #
    # Static
    #
    newstatic
    source $venv/bin/activate
}

function newstatic {
    test -d static/css || mkdir -p static/css
    cat > static/css/styles.css << EOF
h1 {
    color: blue;
}
h2 {
    color: green;
}
h3 {
    color: red;
}
p {
    color: gray;
    font-style: italic;
}
EOF
}

function png {
   mv -v "$(ls -t ~/Pictures/Screenshots/Screenshot* | head -1)" $1.png
}

function getdown {
   mv -iv ~/Downloads/$(ls -t ~/Downloads | head -1) .
}

function git-checkout-pr {
    pull_request=$1
    remote_repo=${2-origin}
    git fetch $remote_repo pull/$pull_request/head:PR$pull_request
    git checkout PR$pull_request
}

function booklet {
    pdftk "$1" cat 4 5 3south 6south 2 7 1south 8south output booklet-"$1"
    lpr -o number-up=2  booklet-"$1" -P PDF
}

function dbtables {
    dbschema $1 | grep "CREATE TABLE" | cut -f 3 -d " " | tr '\n' ' '
}

function dbschema {
    sqlite3 $1 << EOF
.schema
EOF
}

function dbcat {
    db=$1
    for table in $(dbtables $db); do
    echo "SELECT * FROM $table;"
    sqlite3 $db << EOF
.header on
.mode column
SELECT * FROM $table;
EOF

done
}

function undropbox {
    dir=$1
    rsync -av $dir vahtras.se:/mnt
    mv $dir ~/UnDropbox
}
