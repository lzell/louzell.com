## python notes  
  
TODO: This file needs to be formatted.  
  
Also see ~/notes/pip.md  
Also see ~/notes/pyenv.md  
  
  
(python, inspiration, live coding, David Beazley, performance, concurrency, GIL, coroutines)  
https://www.youtube.com/watch?v=MCs5OvhV9S4  
Source: https://news.ycombinator.com/item?id=36785005   
  
(python simple http server, SimpleHTTPServer, python 3)  
  Serve current directory at http://localhost:8000  
  python -m http.server  
  
  
(python, repl, save file)  
  After prototyping in the repl, dump all code I've entered into the repl:  
    %save my_file.py  
  So awesome!  
  
(python, debugging)  
  Examine MRO with:  
    class Foo  
      pass  
    class Bar:  
      pass  
    class Baz(Foo, Bar):  
      pass  
    Baz.__mro__  
  
(python, gotchas)  
  https://github.com/satwikkansal/wtfpython  
  
(pdb, command list)  
  https://docs.python.org/3.6/library/pdb.html#pdbcommand-step  
  `unt` is helpful to get out of a loop  
  Also use `up` and `down`  
  
(ipython, mypy)  
  Check mypy types in the repl with:  
    pip install mypy_ipython  
    ipython  
    %load_ext mypy_ipython  
    ... do some prototyping  
    %mypy  
  
(pdb, pytest)  
  run tests with --pdb to drop you into a repl on test failure  
  
(pytest, mocking)  
  Use `mock.mock_calls` to get a list of all calls sent to a mock.  
  Or `mock.call_args_list`. I'm not sure what the difference is.  
  
(print fstring, debug)  
  x = 'hello'  
  print(f'{x = }')  
  
  Also see alternatives 'ice cream' and 'q': https://github.com/zestyping/q  
  
(pdbpp)  
Use bt to print frames, then  
f [number]  
to jump to one  
  
  
(python modify path)  
PYTHONPATH="./:$PYTHONPATH" python path/to/script.py  
  
(read unit.xml files)  
  Install https://github.com/lukejpreston/xunit-viewer  
  Then  
    pytest --junit-xml=build/unit.xml  
    xunit-viewer -r build/unit.xml  
  
  
(python, pypi, list versions, pip list versions, hack)  
  pip install my-package==  
  
(python zen of python)  
  import this  
  
(python testing sibling library)  
  cd ~/dev/my_app  
  source .env/bin/activate  
  pip install -e ~/dev/my_lib  
  
(python path, pythonpath, modify path, run from vim)  
  :!PYTHONPATH="app:$PYTHONPATH" python %  
  
(files, naming, modules)  
  .py files can be imported as a module, but only if they do not contain hyphens in the name  
  bad: from bad-thing import foo  
  good: from good_thing import foo  
  
(bdist, sdist)  
  See ~/dev/snippets/python/example_package/README.md and the associated  
  package layout  
  
  sdist is a source distribution, build with:  
    python setup.py sdist  
  Build wheel distribution with:  
    python setup.py sdist bdist_wheel  
  
  Note that .whl files can be unzipped with `unzip`  
  
  The distributions are saved in the relative dist/ directory. Untar the source  
  distribution or `unzip` the .whl distribution to debug.  
  
  To include a non-python file in the wheel, the setting `include_package_data`  
  must be True in setup.py AND an include statement must be present in  
  MANIFEST.in  
  
  Wheel is the more modern form of egg: https://packaging.python.org/discussions/wheel-vs-egg/  
  > Wheel is currently considered the standard for built and binary packaging for Python.  
  
  Good slides here: https://blog.ionelmc.ro/presentations/packaging/#slide:1  
  
  
(debugging, python, repl)  
  Pickle is fully specified to reconstruct types  
  Insert breakpoint in problematic process, pickle.dump to file  
  pickle.load in script with debugging aids  
  
(help, repl)  
  Use help(sorted) to see docstring of stdlib sorted function  
  Works with modules:  
    import pickle  
    help(pickle)  
  
(mypy, readme)  
  http://calpaterson.com/mypy-hints.html  
  
(python get size of object, memory, ram, size in bytes)  
  import sys  
  sys.getsizeof(full_dataset)  
See ~/notes/random_notes_worth_keeping.txt search 'memory usage'  
  
(module not found)  
  Seeing: ModuleNotFoundError: No module named '<package>.<folder>'  
  Fix: Add an __init__.py file into <folder>  
  
(pip install git branch)  
  pip install git+https://github.com/<user>/<repo>@<branch>  
  
(python and &, numpy, vectorized and)  
  https://stackoverflow.com/questions/22646463/and-boolean-vs-bitwise-why-difference-in-behavior-with-lists-vs-nump/22647006#22647006  
  
(python2 to python3, migration, equivalence)  
  http://diveinto.org/python3/porting-code-to-python-3-with-2to3.html#next  
  
(python mocking)  
Most articles I've found on python mocking have been junk. Collection of easy to follow tips:  
  https://wesmckinney.com/blog/spying-with-python-mocks/  
  https://stackoverflow.com/a/25424012/143447  
  
(environment variables, env variables, python, virtual env)  
  - In a virtual environment, the path to env is stored at $VIRTUAL_ENV  
  - To add additional env variables, add to the bottom of .env/bin/activate, and  
  also unset inside the `deactivate` function  
  
(find where package is located, installed)  
  $ python -v  
  > import <name-of-package>  
  
(python debugging, pdb)  
  Install pdb++ https://pypi.org/project/pdbpp/  
  pip install pdbpp  
  Then at the debugger prompt, type 'sticky' for a much better debugging experience  
  
(python debugging, pdb, multiline)  
  type 'interact' at the pdb prompt  
  
(virtual environment, virtual env, python2)  
  $ /usr/local/Cellar/python@2/2.7.15_2/bin/pip2.7 install virtualenv  
  $ python2.7 /usr/local/lib/python2.7/site-packages/virtualenv.py .env_2_7  
  $ source .env_2_7/bin/activate  
  
(virtualenv, system python, python 2.7)  
sudo /usr/bin/easy_install-2.7 pip  
/usr/bin/python2.7 -m pip install virtualenv  
cd <location-of-repo>  
/usr/bin/python2.7 -m virtualenv .env  
source .env/bin/activate  
pip install -r requirements.txt  
  
  
(pdb, list, display, source, return to breakpoint)  
  list .  
  
(ipython enter newline)  
  It's tricky to add code to a previous code block after up-arrowing to it. To insert a newline, use:  
  ctlr+o+n or ctrl+q+j  
  
(ipython read file, ipython load, ipython load script)  
  %load filename.py  
  
(ipython, pdb)  
  Use pp to pretty print objects  
  
(pytest hides prints, show print, pytest)  
  pytest -s to show print statements when you run tests  
very confusing that the default setting eats print statements  
  pytest -s -vv to show verbose difference  
  
(pytest stop after first failure)  
  pytest -x  
  
(pytest run single test)  
  pytest -k 'test_the_thing'  
  
(pytest run single file)  
  pytest path/to/file.py  
  
(ipython reload, autoreload, repl)  
  %load_ext autoreload  
  %autoreload 2  
Or add this to ~/.ipython/profile_default/ipython_config.py to automatically  
reload on every session:  
  c.InteractiveShellApp.exec_lines = ['%load_ext autoreload', '%autoreload 2']  
  
(ipython profile, python profile)  
  %prun some_function  
  
  
(virtual environment, python2)  
 $ virtualenv .env  
  
(python create environment, python virtual environment, python3)  
  python -m venv .env  
  (add env to gitignore)  
  source .env/bin/activate  
  [optional]  
    see ~/notes/jupyter.txt  
  deactivate  
  
(venv, virtual env, requirements, freeze)  
  pip freeze > requirements.txt  
  
(python env, git)  
  Add .env to .gitignoremy_environment  
  python -m venv .env  
  source .env/bin/activate  
  pip install -r requirements.txt  
  
  
(readme)  
https://access.redhat.com/blogs/766093/posts/2592591  
  
(ipython, matplotlib, plots, graph, math)  
ipython --matplotlib  
See ~/dev/snippets/python/matplotlib_experiment.py for an example  
  
Within the plot window, use control to pan (drag along the x or y axis), or use  
the zoom rect feature on the toolbar  
  
(ipdb, single variable names)  
Say you have a variable 'n'.  Use exclamation point in front:  
ipdb> !n  
  
  
(string match, methods matching, array select, list includes)  
Find all methods that have pid in it:  
[x for x in dir(os) if re.search('pid', x, re.I)]  # => re.I for ignore case  
  
(getting help, help text, helptext, docstring)  
> help(s.listen)  
or  
> print(s.listen.__doc__)  
  
(print, lambda)  
from __future__ import print_function  
  
Getting list of methods:  
> dir(StringIO.StringIO)  
  
Empty class implementation:  
    class Foo:  
        pass  
  
Debugging  
  
      Get class name:  
      ipdb> x.__class__  
      or  
      ipdb> x.__class__.__name__  
  
  
Packages  
  
      $ pip install numpy  
      $ pip install matplotlib  
      $ pip install ipdb   # => debugger  
  
Autocompletion:  
  
                  $ pip install jedi  
    ~/.vim/bundle $ git clone --recursive https://github.com/davidhalter/jedi-vim.git  
  
Interactive python:  
  
    $ python -i  
    Better:  
    $ ipython  
  
System python installs to   
pip installs things to: /usr/local/lib/python2.7/site-packages  
  
  
Pretty printing:  
  
    import pprint  
    params = {  
        'latitude': 37.775818,  
        'longitude': -122.418028,  
        'server_token': 'snip'  
    }  
    pp = pprint.PrettyPrinter(indent=4, width=1).pprint  
    pp(params)  
  
Pretty printing something that resembles a dictionary  
  
    pp(dict(response.headers))   # => note the width of 1 above is important  
  
  
Patches  
(python debugger, ipdb, list, patch):  
In /home/lou/dragon/lib/python2.7/site-packages/IPython/core/debugger.py,  
Changed context from 3 to 10:  
  
    def print_stack_entry(self,frame_lineno,prompt_prefix='\n-> ',  
                          context = 10):  
  
  
Configuring iPython  
  
    Create default profile:  
    $ ipython profile create  
    $ ipython locate profile  
  
* cd to that and find the 'startup' folder (currently at ~/.ipython/profile_default/startup)  
* added in a script to import pprint and configure it  
  
  
iPython tricks  
  
    Run a script:  
    > %run workbench.py  
  
Insert an enter (newline) in repl:  
  
    ctrl+v + ctlr+j  
  
Also try %edit  
  
  
Exec from command line  
  
    python -c "print('sup')"  
  
  
Sys  
  
    import sys  
    sys.path  
  
  
Entry detection  
  
    if __name__ == '__main__':  
        print("yes, I am main")  
