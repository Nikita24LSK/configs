# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export QT_QPA_PLATFORMTHEME="qt5ct"
export JAVA_HOME=/usr/lib/jvm/java-25-openjdk/
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/build-tools/36.1.0
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
plugins=(git zsh-autosuggestions dirhistory zsh-syntax-highlighting zsh-autopair pass)

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

function install_venv_packages() {
  venv_type="$1"

  if [[ "$venv_type" == "local" ]]; then
    default_answers=("" "Y" "y" "yes")
    answer_sign="[Y/n]"
  else
    default_answers=("Y" "y" "yes")
    answer_sign="[y/N]"
  fi

  if [[ -f "./requirements.txt" ]]; then
    echo -n "requirements.txt has been found. Install it? ${answer_sign} "
    read -r answer

    if [[ ${default_answers[(i)$answer]} -le ${#default_answers} ]]; then
      python3 -m pip install -r ./requirements.txt
    fi
  fi

  echo -en "\nEnter venv packages for install: "
  read -r packages
  packages=(${=packages})

  test "${#packages[@]}" -gt 0 && python3 -m pip install "${packages[@]}"
}

function get_venv() {
  venvs_list=$1
  venv_name=$2

  if [[ "$venv_name" == "" ]]; then
    venv_name=$(echo $venvs_list | fzf)
    if [[ "$venv_name" == "" ]]; then
      echo "Cancelled!"
    fi
  fi

  if [[ "$venv_name" != "" ]]; then
    if [[ ! -d "$VENVS_DIR/$venv_name" || ! -f "$VENVS_DIR/$venv_name/bin/activate" ]]; then
      echo "Error! Venv ${venv_name} does not exists!"
      venv_name=""
    fi
  fi

  echo $venv_name
}

function venvs () {
  cmd=$1
  venv_name=$2
  is_new_venv=false
  venv_type="remote"

  if [[ "$cmd" == "-h" || "$cmd" == "--help" || "$cmd" == "h" || "$cmd" == "help" ]]; then
    echo -e "Python virtual env manager:\n" \
      "Usage: venvs <command> [venv_name]\n" \
      "Commands:\n" \
      "\t<empty> or s - select and activate venv inside VENVS_DIR (default action)\n" \
      "\ta - show all venvs inside VENVS_DIR\n" \
      "\tl - init local venv\n" \
      "\tn - create new venv inside VENVS_DIR\n" \
      "\tr - remove venv from VENV_DIRS\n\n"

    return 0
  fi

  if [[ "$cmd" == "l" ]]; then
    venv_type="local"
    venv_name=${venv_name:="venv"}
    init_file="./${venv_name}/bin/activate"
    venv_dir="./${venv_name}"

    if [[ -e ${venv_dir} && (! -d ${venv_dir} || ! -e ${init_file}) ]]; then
      echo "Error! Object with name '${venv_name}' already exists!"
      return -1
    fi

    if [[ ! -e ${venv_dir} ]]; then
      python3 -m venv "${venv_name}"
      is_new_venv=true
    fi
  else
    if [[ "$VENVS_DIR" == "" || ! -d "$VENVS_DIR" ]]; then
      echo "Incorrect VENVS_DIR value!"
      return -1
    fi

    venvs_list=$(ls $VENVS_DIR)
    if [[ "$venvs_list" == "" && "$cmd" != "n" ]]; then
      echo "Venvs dir is empty!"
      return -1
    fi

    if [[ "$cmd" == "a" ]]; then
      echo $venvs_list
      return 0
    fi

    if [[ "$cmd" == "r" ]]; then
      venv_name=$(get_venv $venvs_list $venv_name)
      if [[ "$venv_name" == "" ]]; then
        return -1
      else
        rm -rf $VENVS_DIR/$venv_name
        return 0
      fi
    fi

    if [[ "$cmd" == "" || "$cmd" == "s" ]]; then
      venv_name=$(get_venv $venvs_list $venv_name)
      if [[ "$venv_name" == "" ]]; then
        return -1
      fi

      init_file="$VENVS_DIR/$venv_name/bin/activate"
    fi

    if [[ "$cmd" == "n" ]]; then
      if [[ "$venv_name" == "" ]]; then
        echo -n "Enter venv name: "
        read venv_name

        if [[ "$venv_name" == "" ]]; then
          echo "Incorrect venv name!"
          return -1
        fi
      fi

      init_file="$VENVS_DIR/$venv_name/bin/activate"

      if [[ -e "$VENVS_DIR/$venv_name" && (! -d "$VENVS_DIR/$venv_name" || ! -e ${init_file}) ]]; then
        echo "Error! Object with name '${venv_name}' already exists!"
        return -1
      fi

      python3 -m venv "$VENVS_DIR/$venv_name"
      is_new_venv=true
    fi
  fi

  source ${init_file}

  if [[ "$is_new_venv" == "true" ]]; then
    install_venv_packages $venv_type
  fi

  return 0
}

function long_task() {
  task_str="${@}"
  $@ && notify-send -t 0 "Long Task: Success" ${task_str} || notify-send -t 0 "Long Task: Fail" ${task_str}
}

# Aliases

alias vim="nvim"
alias termrc="cd ~/.config/alacritty/ && nvim ./alacritty.toml && cd -"
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
alias py="ipython"

# Exports of environment variables

export EDITOR=nvim

