# FZF Quick Reference
Helpers implemented as per [FZF Examples](https://github.com/junegunn/fzf/wiki/examples#general).
## General - f and fm
Use fd and fzf to get the args to a command, works only with zsh
f is recursive while fm is limited to current directory
Examples:
```shell
f mv # To move files. You can write the destination after selecting the files.
f 'echo Selected:'
f 'echo Selected music:' --extention mp3
fm rm # To rm files in current directory
```
## Opening and viewing files
My commands
```shell
vimf # open with vim
catf # view with cat/bat
glowg # render markdown with glow
```
From reference
``` shell
fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo [FUZZY PATTERN] # Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR

vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
vg - fuzzy grep open via ag
```
## Changing directory
``` shell
fd - cd to selected directory
fda - including hidden directories
fdr - cd to selected parent directory
cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
cdf - cd into the directory of the selected file
```
## Searching file contents
``` shell
# using ripgrep combined with preview
# find-in-file - usage:
fif <searchTerm>
# alternative using ripgrep-all (rga) combined with fzf-tmux preview
fif_rga <searchTerm>
```
## Processes
``` shell
fkill - kill processes - list only the ones you can kill. Modified the earlier script.
```
## Git
``` shell
fbr - checkout git branch (including remote branches)
fco - checkout git branch/tag
fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fcoc - checkout git commit
fshow - git commit browser
fcoc_preview - checkout git commit with previews
fshow_preview - git commit browser with previews
fcs - get git commit sha
# example usage: git rebase -i `fcs`
fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
```
## Tags
``` shell
ftags - search ctags
ftags_prvw - search ctags with preview
# only works if tags-file was generated with --excmd=number
```
## Homebrew
``` shell
bip
Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bup
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bcp
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)

# Homebrew Cask
install
# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
uninstall
# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
```
