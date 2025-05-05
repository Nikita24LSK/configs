# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export BASE_DIR=/data/data/com.termux/files
export ZSH=$HOME/.oh-my-zsh
export JAVA_HOME=$BASE_DIR/usr/lib/jvm/java-17-openjdk
export GOPATH=$HOME/go
export USERDATA="/storage/emulated/0/Documents/Termux"
export TERM="xterm-256color"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple"

setopt prompt_subst

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions dirhistory zsh-syntax-highlighting zsh-autopair sudo)

source $ZSH/oh-my-zsh.sh
source /data/data/com.termux/files/usr/share/fzf/completion.zsh
source /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Aliases

alias ud="cd /storage/emulated/0/Documents/Termux"
alias vim="nvim"
alias vimrc="cd ~/.config/nvim/lua/custom/ && nvim ./init.lua && cd -"
alias svim="sudo nvim"
alias svifm="sudo vifm"
alias zshrc="nvim ~/.zshrc"
alias pacconf="nvim $PREFIX/etc/apt/sources.list"
alias pacup="apt update && apt -y upgrade"
alias pacsearch="apt search"
alias pacinst="apt list 2>/dev/null | grep -v "installed" | awk -F'/' 'NR>1 {print \$1}' | fzf -m --color=bw --preview-window=up:55\%:wrap --preview 'apt info {} 2>/dev/null' | xargs -r apt install -y"
alias pacdel="apt list --installed 2>/dev/null | awk -F'/' 'NR>1 {print \$1}' | fzf -m --color=bw --preview-window=up:55\%:wrap --preview 'apt info {} 2>/dev/null' | xargs -r apt remove -y"

# alias sysrw="$HOME/.shortcuts/tasks/sysrw"
alias sshsrv="$HOME/.shortcuts/sshsrv"
alias frida-inject="su -c $HOME/frida//frida-inject"
alias frida-server="su -c $HOME/frida//frida-server -l 127.0.0.1 -D"
alias frida="sudo frida"
alias frida-ps="sudo frida-ps"
alias frida-trace="sudo frida-trace"
alias datasync="$HOME/.termux/boot/syncthing"

# Exports of environment variables

export EDITOR=nvim

