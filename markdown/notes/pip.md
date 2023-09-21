## pip notes  
  
### How to start python projects  
  
    cd <my-project>  
    pyenv local 3.8.17  
    python -m venv venv  
    source venv/bin/activate  
    pip install --upgrade pip  
    pip install pip-tools  
  
  
### How to update dependencies  
  
Add deps to `requirements.in`, then:  
  
    pip-compile  
  
Commit `requirements.txt` and `requirements.in`. Then  
  
    pip install -r requirements.txt  
  
(Note: Do not use this method for libs. For libs, edit `setup.cfg` instead)  
  
  
### How to list installed packages  
  
    pip list  
  
  
### How to show which pypi index is used  
      
    pip config list  
  
  
### How to list outdated dependencies   
  
    pip list --outdated  
  
  
### How to add a local lib as a dependency  
  
This adds `my-lib` as a dependency to `my-app`:  
  
    mkdir ~/dev/my-app  
    cd ~/dev/my-app  
    pyenv local <version>  
    python -m venv .env  
    source .env/bin/activate  
    pip install --upgrade pip  
    pip install wheel  
    pip install -e ~/dev/my-lib  
  
  
### How to upgrade a package, update a package  
It's best to update in `requirements.in`, but for hacking:  
  
    pip install --upgrade scipy  
  
  
### How to check if dependencies are satisfied   
  
    pip check  
  
  
### How to install dependencies from a requirements file  
  
    pip install -r requirements3.txt  
