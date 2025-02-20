## pyenv notes  
  
### How to set the default python version  
  
    pyenv install <version>  
    pyenv global <version>  
  
  
### How to set a project local python version  
  
    pyenv local <version>  
  
or  
  
    echo "3.8.13" > .python-version  
    pyenv install < .python-version  
  
  
### How to create a new python project  
  
    cd <my-project>  
    python -m venv venv  
    source venv/bin/activate  
  
  
### How to verify which version of python I'm using  
  
    cd <my-project>  
    source venv/bin/activate  
    python --version  
  
  
### How to list installed python versions  
  
    pyenv versions  
  
  
### How to list possible pyenv versions  
  
    pyenv install --list  
  
or  
  
    pyenv install --list | grep 3.8  
  
  
### How to install pyenv on big sur  
https://github.com/pyenv/pyenv/issues/1764  
https://github.com/pyenv/pyenv/issues/1740  
