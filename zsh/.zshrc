# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# export QT_QPA_PLATFORMTHEME="qt5ct"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/build-tools/34.0.0
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

function venv_manager() {
  venv_num=$1
  if [[ "$VENVS_DIR" == "" ]]; then
    echo -e "\nVenvs dir is not set. Please set variable VENVS_DIR in zshrc\n"
    return 0
  fi

  echo -e "Venvs dir is: $VENVS_DIR"

  if [ ! -d $VENVS_DIR ]; then
    echo -e "Venvs dir does not exists :(\n"
    return 0
  fi

  dir_list=($(ls $VENVS_DIR))
  if [[ "${#dir_list[@]}" == "0" ]]; then
    echo -e "Venvs dir is empty :(\n"
    return 0
  fi
  
  venvs=""

  for file in ${dir_list[@]}; do
    if [ ! -d $VENVS_DIR/$file ] || [ ! -f $VENVS_DIR/$file/bin/activate ]; then
      continue
    fi

    venvs="$venvs $file"
  done

  venvs=(${=venvs})

  if [[ "${#venvs[@]}" == "0" ]]; then
    echo -e "There is no Python venvs :(\n"
    return 0
  fi

  if [[ "$venv_num" == "" ]]; then
    for (( i=1; i<$(( ${#venvs[@]}+1 )); i++ ))
    do
      echo -e "[$(( $i ))] ${venvs[$i]}"
    done
    echo -e "[$(( i ))] cancel\n"

    read "?Choice venv: " choice
    
    if [[ "$choice" == "$(( i ))" ]]; then
      echo -e "Canceling...\n"
      return 0
    fi
  else
    choice=$venv_num
  fi

  venv=${venvs[$choice]}

  echo -e "Activate venv: $venv\n"

  activate_script=$VENVS_DIR/$venv/bin/activate

  source $activate_script
}

function long_task() {
  task_str="${@}"
  $@ && notify-send -t 0 "Long Task: Success" ${task_str} || notify-send -t 0 "Long Task: Fail" ${task_str}
}

# Aliases

alias vim="nvim"
alias termrc="cd ~/.config/alacritty/ && nvim ./alacritty.yml && cd -"
alias vimrc="cd ~/.config/nvim/lua/custom/ && nvim ./init.lua && cd -"
alias picomrc="cd ~/.config/picom/ && nvim ./picom.conf && cd -"
alias bsprc="cd ~/.config/bspwm && nvim ./bspwmrc && cd -"
alias sxhkdrc="cd ~/.config/sxhkd/ && nvim ./sxhkdrc && cd -"
alias ewwrc="cd ~/.config/eww/bar_horizontal && nvim ./eww.yuck && cd -"
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
alias scan="scanimage --device \"airscan:e0:Pantum-M6500W-Series 85133B\" --format=png --output-file"

# Exports of environment variables

export EDITOR=nvim


