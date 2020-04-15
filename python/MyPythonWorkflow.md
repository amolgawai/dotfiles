Python Development Workflow
===============

Introduction
------------
This is my development setup for python. The inetended use is for generic Python development and more specifically AI-ML development

Environment
-----------
OS - MacOS (Catalina - 10.15.3 )
Editor - Emacs with [elpy](https://github.com/jorgenschaefer/elpy)
Shell - [zsh](https://www.zsh.org/)

Concept
-------
  * **DO NOT** use the system python - The system python tends to be old as of this writing
  * **DO NOT** manage python with homebrew
  * Use a python manager - to separate cutting edge vs proven versions
  * Use virtual environments - to separate the package needs for different kind of applications
  * Use a python dependency and packaging manager - to manage installation, maintainance and reproduciability of the app eco
  * Use a code formatter - [black](https://github.com/psf/black) is the choice for now

Workflow and tools
------------------
### Install Python manager ###
[pyenv](https://github.com/pyenv/pyenv)

``` shell
$ brew install pyenv
```
Add `pyenv init `to your shell to enable shims and autocompletion. Please make sure eval "$(pyenv init -)" is placed toward the end of the shell configuration file since it manipulates PATH during the initialization.

``` shell
$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
```
Restart the shell and pyenv is ready.

Basic commands to manage python versions with pyenv

``` shell
# list available python versions
$ pyenv install --list

# install python 3.8.2
$ pyenv install 3.8.2

# list installed python versions, * means the global default
$ pyenv versions
* system
3.8.1

# set the global default to 3.8.2
$ pyenv global 3.8.1
```

### Install virtual environment manager ###
[pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)

``` shell
$ brew install pyenv-virtualenv

# add initialize script in your bash configuration file
$ echo ‘eval “$(pyenv virtualenv-init -)”’ >> ~/.zshrc
```
Restart the shell so that virtual environments can be created

``` shell
# Create a virtualenv for a project
$ pyenv virtualenv 3.8.2 myVirtEnv

# To set and automatically switch to a virtual environment for a project
$ cd path-to-your-direcotry
$ pyenv local myVirtEnv
```

### Install dependency and packaging manager ###
[poetry](https://python-poetry.org/docs/)

``` shell
$ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# add this to your shell rc
$ source $HOME/.poetry/env


# For tab completion in your shell, see the documentation
poetry help completions

# Configure poetry to create virtual environments inside the project's root directory
poetry config virtualenvs.in-project true
```
### Install packages for an environment ###
With the above setup, now we can install packages for a perticular project with poetry

``` shell
# cd to the project directory, this will activate the virtual environment
$ cd path-to-your-direcotry

$ poetry add pandas numpy scipy tensorflow=2.1.0rc2 tensorflow-text matplotlib scikit-learn jupyter ipykernel

# Specify some dev libraries
$ poetry add --dev black flake8
```

### Emacs workflow ###
Open a python project in emacs with projectile
Activate virtual environment `pyvenv-workon`
Enjoy the development

References
----------
1. [Setting Up Python: pyenv, pyenv-virtualenv, poetry](https://duncanleung.com/set-up-python-pyenv-virtualenv-poetry/)
2. [Get started with pyenv & poetry. Saviours in the python chaos!](https://blog.jayway.com/2019/12/28/pyenv-poetry-saviours-in-the-python-chaos/)
