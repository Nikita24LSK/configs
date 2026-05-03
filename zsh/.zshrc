# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# export QT_QPA_PLATFORMTHEME="qt5ct"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$PATH:$HOME/.local/bin
export LIBVIRT_DEFAULT_URI=qemu:///system
export TERM="xterm-256color"
export ZDOTDIR=$HOME
export VENVS_DIR="$HOME/prog/venvs"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

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
DISABLE_AUTO_TITLE="true"

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
plugins=(git zsh-autosuggestions dirhistory zsh-syntax-highlighting sudo zsh-autopair)

source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

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

function venvs ()
{
  if [[ "$VENVS_DIR" == "" || ! -d "$VENVS_DIR" ]]; then
    echo "Incorrect VENVS_DIR value!"
    return -1
  fi

  arg=$1
  venv_name=$2

  venvs_list=$(ls $VENVS_DIR)
  if [[ "$venvs_list" == "" && "$arg" != "n" ]]; then
    echo "Venv dir is empty!"
    return -1
  fi

  if [[ ("$arg" == "" || "$arg" == "s" || "$arg" == "r") && "$venv_name" == "" ]]; then
    venv_name=$(ls $VENVS_DIR | fzf)

    if [[ "$venv_name" == "" ]]; then
      echo "Cancelled!"
      return 0
    fi
  fi

  if [[ ("$arg" == "" || "$arg" == "s" || "$arg" == "r") && "$venv_name" != "" && ! -d "$VENVS_DIR/$venv_name" ]]; then
    echo "$venv_name does not exists!"
    return -1
  fi

  if [[ "$arg" == "l" ]]; then
    echo $venvs_list
  elif [[ "$arg" == "s" || "$arg" == "" ]]; then
    source $VENVS_DIR/$venv_name/bin/activate
  elif [[ "$arg" == "r" ]]; then
    rm -rf $VENVS_DIR/$venv_name
  elif [[ "$arg" == "n" ]]; then
    if [[ "$venv_name" == "" ]]; then
      echo -n "Enter venv name: "
      read venv_name

      if [[ "$venv_name" == "" ]]; then
        echo "Incorrect venv name!"
        return -1
      fi
    fi

    if [[ -d "$VENVS_DIR/$venv_name" ]]; then
      echo "Venv $venv_name already exists!"
      return -1
    fi

    python -m venv "$VENVS_DIR/$venv_name"
  fi

  return 0
}

function long_task() {
  task_str="${@}"
  $@ && notify-send -t 0 "Long Task: Success" ${task_str} || notify-send -t 0 "Long Task: Fail" ${task_str}
}

# Aliases

alias vim="nvim"
alias zshrc="nvim ~/.zshrc"
alias sshfs_umount="fusermount3 -u"
alias pacconf="sudo nvim /etc/pacman.conf"
alias pacup="sudo pacman -Suy"
alias pacinst="pacman -Sl | grep -v 'installed' | awk '{print \$2}' | fzf --color=bw -m --preview 'pacman -Si {}' --preview-window=right:55\%:wrap | xargs -r sudo pacman -S --noconfirm"
alias pacdel="pacman -Sl | grep 'installed' | awk '{print \$2}' | fzf --color=bw -m --preview 'pacman -Si {}' --preview-window=right:55\%:wrap | xargs -r sudo pacman -Rns --noconfirm"
alias syslist="systemctl list-unit-files"
alias sysreload="sudo systemctl daemon-reload"
alias systart="sudo systemctl start"
alias systop="sudo systemctl stop"
alias sysrestart="sudo systemctl restart"
alias systatus="sudo systemctl status"
alias sysenable="sudo systemctl enable"
alias sysdisable="sudo systemctl disable"
alias svim="sudo nvim"
alias svifm="sudo vifm"
alias dimg="docker image ls -a"
alias dcont="docker container ls -a"
alias dimgrm="docker image rm"
alias dcontrm="docker container rm"

# Exports of environment variables

export EDITOR=nvim


