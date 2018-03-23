# oh-my-zsh
export ZSH=/Users/witekbobrowski/.oh-my-zsh

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="cobalt2"

ENABLE_CORRECTION="true"

# Plugins
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias lc='colorls'
alias jn="jupyter notebook"
alias xcode="open -a Xcode"
alias purgedd='rm -rf ~/Library/Developer/Xcode/DerivedData/*'

function chpwd() {
    emulate -L zsh
    colorls -a
}
