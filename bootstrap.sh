#!/usr/bin/env bash
#
# bootstrap installs things.

# cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''
function coloredEcho() {
    local exp="$1";
    local color="$2";
    local arrow="$3";
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold;
    tput setaf "$color";
    echo "$arrow $exp";
    tput sgr0;
}

function user() {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}


function info() {
    coloredEcho "$1" blue "========>"
}

function substep() {
    coloredEcho "$1" magenta "===="
}

function success() {
    coloredEcho "$1" green "========>"
}

function error() {
    coloredEcho "$1" red "========>"
}

function symlink() {
    application=$1
    point_to=$2
    destination=$3
    destination_dir=$(dirname "$destination")

    if test ! -e "$destination_dir"; then
        substep "Creating ${destination_dir}"
        mkdir -p "$destination_dir"
    fi
    if rm -rf "$destination" && ln -s "$point_to" "$destination"; then
        substep "Symlinking for \"${application}\" done"
    else
        error "Symlinking for \"${application}\" failed"
        exit 1
    fi
}

function ask_for_sudo() {
    info "Prompting for sudo password"
    if sudo --validate; then
        # Keep-alive
        while true; do sudo --non-interactive true; \
            sleep 10; kill -0 "$$" || exit; done 2>/dev/null &
        success "Sudo password updated"
    else
        error "Sudo password update failed"
        exit 1
    fi
}

function setup_gitconfig() {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}

function install_xcode_command_line_tools() {
    info "Installing Xcode command line tools"
    if softwareupdate --history | grep --silent "Command Line Tools"; then
        success "Xcode command line tools already exists"
    else
        xcode-select --install
        read -n 1 -s -r -p "Press any key once installation is complete"

        if softwareupdate --history | grep --silent "Command Line Tools"; then
            success "Xcode command line tools installation succeeded"
        else
            error "Xcode command line tools installation failed"
            exit 1
        fi
    fi
}

function install_homebrew () {
    info "Installing Homebrew"
    if hash brew 2>/dev/null; then
        success "Homebrew already exists"
    else
        url=https://raw.githubusercontent.com/Homebrew/install/master/install
        if yes | /usr/bin/ruby -e "$(curl -fsSL ${url})"; then
            success "Homebrew installation succeeded"
        else
            error "Homebrew installation failed"
            exit 1
        fi
    fi
    # Make sure we’re using the latest Homebrew.
    brew update

    # Upgrade any already-installed formulae.
    brew upgrade
}

function install_oh_my_zsh () {
    info "Installing oh_my_zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    success "Oh my zsh installation succeeded"
}

function install_zsh_plugins () {
    info "Installing powerlevel10k theme"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    info "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    info "Installing fast-syntax-highlighting"
    git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
    info "Installing alias-tips"
    git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

    success "zsh Plugin installation succeeded"
}

function setup_emacsadventures () {
    info "setting up emacsadventures"
    if test -d ~/code/emacsadventures; then
        substep "emacsadventures available"
    else
        substep "downloading emacsadventures"
        git clone https://github.com/amolgawai/emacsadventures.git ~/code/emacsadventures
    fi
    if  test ! -e ~/.emacs.d/emacsadventures; then
        mkdir ~/.emacs.d/emacsadventures
    fi
    symlink "emacsadventure" ~/code/emacsadventures ~/.emacs.d/emacsadventures
    echo "(load \"~/.emacs.d/emacsadventures/loadMyConfig.el\")" > ~/.emacs.d/init.el
    success "emacsadventures setup succeeded"
}

function create_directories () {
    info "Creating basic directories"
    if test -d ~/code; then
        substep "code directory exists"
    else
        mkdir ~/code
    fi
    if test -d ~/.emacs.d; then
        substep "backing up emacs directory"
        mv ~/.emacs.d ~/.emacs.d.bak
    fi
    mkdir ~/.emacs.d
    success "directory creation succeeded"

}

function install_packages_with_brewfile() {
    info "Installing Brewfile packages"

    TAP=${DOTFILES_ROOT}/brew/Brewfile_tap
    BREW=${DOTFILES_ROOT}/brew/Brewfile_brew
    CASK=${DOTFILES_ROOT}/brew/Brewfile_cask
#    MAS=${DOTFILES_ROOT}/brew/Brewfile_mas
#    echo $TAP; echo $BREW; echo $CASK; echo $MAS

    if hash parallel 2>/dev/null; then
        substep "parallel already exists"
    else
        if brew install parallel &> /dev/null; then
            printf 'will cite' | parallel --citation &> /dev/null
            substep "parallel installation succeeded"
        else
            error "parallel installation failed"
            exit 1
        fi
    fi

#    if (echo $TAP; echo $BREW; echo $CASK; echo $MAS) | parallel --verbose --linebuffer -j 4 brew bundle check --file={} &> /dev/null; then
    if (echo $TAP; echo $BREW; echo $CASK) | parallel --verbose --linebuffer -j 4 brew bundle check --file={} &> /dev/null; then
        success "Brewfile packages are already installed"
    else
        if brew bundle --file="$TAP"; then
            substep "Brewfile_tap installation succeeded"

            export HOMEBREW_CASK_OPTS="--no-quarantine"
            if (echo $BREW; echo $CASK; echo $MAS) | parallel --verbose --linebuffer -j 3 brew bundle --file={}; then
                success "Brewfile packages installation succeeded"
            else
                error "Brewfile packages installation failed"
                exit 1
            fi
        else
            error "Brewfile_tap installation failed"
            exit 1
        fi
    fi
}


function setup_symlinks() {
#    APPLICATION_SUPPORT=~/Library/Application\ Support
#    POWERLINE_ROOT_REPO=/usr/local/lib/python3.7/site-packages

    info "Setting up symlinks"
#    symlink "git" ${DOTFILES_ROOT}/git/gitconfig ~/.gitconfig
#    symlink "hammerspoon" ${DOTFILES_ROOT}/hammerspoon ~/.hammerspoon
#    symlink "karabiner" ${DOTFILES_ROOT}/karabiner ~/.config/karabiner
#    symlink "powerline" ${DOTFILES_ROOT}/powerline ${POWERLINE_ROOT_ROOT}/powerline/config_files
    symlink "tmux" ${DOTFILES_ROOT}/tmux/tmux.conf ~/.tmux.conf
    symlink "vim" ${DOTFILES_ROOT}/vim/vimrc ~/.vimrc
	symlink "zsh" ${DOTFILES_ROOT}/zsh/.zshrc ~/.zshrc

    # Disable shell login message
#    symlink "hushlogin" /dev/null ~/.hushlogin

#    symlink "fish:completions" ${DOTFILES_ROOT}/fish/completions ~/.config/fish/completions
#    symlink "fish:functions"   ${DOTFILES_ROOT}/fish/functions   ~/.config/fish/functions
#    symlink "fish:config.fish" ${DOTFILES_ROOT}/fish/config.fish ~/.config/fish/config.fish
#    symlink "fish:oh_my_fish"  ${DOTFILES_ROOT}/fish/oh_my_fish  ~/.config/omf

    success "Symlinks successfully setup"
}

function setup_vim() {
    info "Setting up vim"
    substep "Installing Vundle"
    if test -e ~/.vim/bundle/Vundle.vim; then
        substep "Vundle already exists"
        pull_latest ~/.vim/bundle/Vundle.vim
        substep "Pull successful in Vundle's repository"
    else
        url=https://github.com/VundleVim/Vundle.vim.git
        if git clone "$url" ~/.vim/bundle/Vundle.vim; then
            substep "Vundle installation succeeded"
        else
            error "Vundle installation failed"
            exit 1
        fi
    fi
    substep "Installing all plugins"
    if vim +PluginInstall +qall 2> /dev/null; then
        substep "Plugins installations succeeded"
    else
        error "Plugins installations failed"
        exit 1
    fi
    success "vim successfully setup"
}

function setup_tmux() {
    info "Setting up tmux"
    substep "Installing tpm"
    if test -e ~/.tmux/plugins/tpm; then
        substep "tpm already exists"
        pull_latest ~/.tmux/plugins/tpm
        substep "Pull successful in tpm's repository"
    else
        url=https://github.com/tmux-plugins/tpm
        if git clone "$url" ~/.tmux/plugins/tpm; then
            substep "tpm installation succeeded"
        else
            error "tpm installation failed"
            exit 1
        fi
    fi

    substep "Installing all plugins"

    # sourcing .tmux.conf is necessary for tpm
    tmux source-file ~/.tmux.conf 2> /dev/null

    if ~/.tmux/plugins/tpm/bin/./install_plugins &> /dev/null; then
        substep "Plugins installations succeeded"
    else
        error "Plugins installations failed"
        exit 1
    fi
    success "tmux successfully setup"
}

main() {
    ask_for_sudo
    install_xcode_command_line_tools # to get "git", needed for clone_dotfiles_repo
#	setup_gitconfig
#	clone_dotfiles_repo
    install_homebrew
    install_packages_with_brewfile
    install_oh_my_zsh
    install_zsh_plugins
    create_directories
    setup_emacsadventures
#    change_shell_to_fish
#   install_pip_packages
#    install_yarn_packages
     setup_symlinks # needed for setup_vim and setup_tmux
     setup_vim
     setup_tmux
#    update_hosts_file
#    setup_macOS_defaults
#    update_login_items
}

main "$@"
