# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# path
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cobalt2"

# Plugins
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Configurating thefuck
eval $(thefuck --alias)

# Aliases

### Files
alias grc="nvim ~/.gitconfig"
alias zrc="nvim ~/.zshrc"
alias vrc="nvim ~/.config/nvim/init.vim"
alias omz="nvim ~/.oh-my-zsh"

### Directories
alias dev="cd ~/Developer"
alias devp="cd ~/Developer/personal"
alias devw="cd ~/Developer/work"
alias devt="cd ~/Developer/temp"
alias dotf="cd ~/Developer/personal/dotfiles"
alias docs="cd ~/Documents"
alias dwnl="cd ~/Downloads"
alias dsk="cd ~/Desktop"

### Programs
alias e='nvim'
alias lc='colorls'
alias jn="jupyter notebook"

### Commands
alias pdd='rm -rf ~/Library/Developer/Xcode/DerivedData/*' # Purge DerivedData
alias gmc= "find . -name '*.orig' -delete" # Clean after git merge

# lc on cd
function chpwd() {
    emulate -L zsh
    colorls -a
}

# Update all Wallpapers
function wallpaper() {
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$1'" && killall Dock
}

# Show friendly cow on new session
clear && cowsay sup fam | lolcat
