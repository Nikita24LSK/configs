function battery_charge {
  bat_path="/sys/class/power_supply/BAT1/"
  bat_percent="$(cat "$bat_path/capacity")"
  bat_status="$(cat "$bat_path/status")"

  if [ $bat_percent -lt 20 ]; then local bat_color='%B%F{red}'
  elif [ $bat_percent -lt 50 ]; then local bat_color='%B%F{yellow}'
  else local bat_color='%B%F{green}'
  fi

  if [[ $bat_status == "Charging" ]]; then local sym_status="󰂏 "
  else local sym_status="󰂌 "
  fi

  echo  $bat_color$sym_status$bat_percent%%'%F{default}%b'
}

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
${time} ${user_name} \$(battery_charge)
${current_dir}
${git_branch}${under_vifm} ${user_symbol} "

