function battery_charge {
  bat_percent=`acpi | grep -Eo "[0-9]{1,3}%" | grep -Eo "[0-9]{1,3}"`
  bat_status=`acpi | grep -Eo "Charging|Discharging"`

  if [ $bat_percent -lt 20 ]; then local bat_color='%B%F{red}'
  elif [ $bat_percent -lt 50 ]; then local bat_color='%B%F{yellow}'
  else local bat_color='%B%F{green}'
  fi

  if [[ $bat_status == "Charging" ]]; then local sym_status="+"
  else local sym_status="-"
  fi

  echo  $bat_color$sym_status$bat_percent%%'%F{default}%b'
}

if [[ $UID -eq 0 ]]; then
	local user_color=red
else
	local user_color=green
fi

local user_name='%B%F{$user_color}%n%F{default}%b'
local user_symbol='%B%F{$user_color}~>%F{default}%b'
time='%B%F{cyan}%*%F{default}%b'

local current_dir='%B%F{blue}%~%F{default}%b'
local git_branch='%B%F{yellow}$(git_prompt_info)%F{default}%b'

PROMPT="
${time} \$(battery_charge) ${current_dir}
${git_branch} ${user_symbol} "

