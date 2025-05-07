function git_prompt {
  branch=$(git_current_branch)
  is_dirty=$(parse_git_dirty)

  if [[ $branch == "" ]]; then
    echo ""
  else
    echo " ($branch$is_dirty) "
  fi
}

function is_under_vifm {
  parent=$(ps -o comm= -p $(ps -o ppid= -p $(echo $$)))

  if [[ "${parent}" == "vifm" ]]; then
    echo ""
  else
    echo ""
  fi
}

if [[ $UID -eq 0 ]]; then
	local user_color=red
else
	local user_color=green
fi

local user_name='%B%F{$user_color} %n%F{default}%b'
local user_symbol='%B%F{$user_color}➜%F{default}%b'
time='%B%F{cyan}󰥔 %*%F{default}%b'

local current_dir='%B%F{blue} %~%F{default}%b'
local git_branch='%B%F{yellow}$(git_prompt)%F{default}%b'
local under_vifm='%B%F{green}$(is_under_vifm)%F{default}%b'

PROMPT="
${time} ${user_name}
${current_dir}
${git_branch}${under_vifm} ${user_symbol} "

