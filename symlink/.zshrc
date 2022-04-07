# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# path
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export FASTLANE_PATH="/usr/local/lib/ruby/gems/2.6.0/gems/fastlane-2.134.0/bin"
export PATH="$FASTLANE_PATH:$PATH"

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

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

alias pip=/usr/local/bin/pip3

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
alias g='git'
alias gp='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias t='tmux'
alias tls='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tre='tmux rename-session -t'
alias r='ranger'
alias lc='colorls'
alias jn='jupyter notebook'
alias gc='git cim'

### Commands
alias ffusb='sudo killall -STOP -c usbd' # Fix fucking usb charging by killing the process
alias pdd='rm -rf ~/Library/Developer/Xcode/DerivedData/*' # Purge DerivedData
alias gmc= "find . -name '*.orig' -delete" # Clean after git merge

# lc on cd
function chpwd() {
    emulate -L zsh
    colorls --almost-all
}

# Update all Wallpapers
function wallpaper() {
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$1'" && killall Dock
}

# Replace apple id mail in fastlane config
function rfm() {
    sed -i '' 's/^apple_id.*/apple_id "witek@bobrowski.co"/g' fastlane/Appfile
}

# Show friendly cow on new session
clear && cowsay sup fam | lolcat

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
