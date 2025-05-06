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

PROMPT="
${time} ${user_name}
${current_dir}
${git_branch} ${user_symbol} "

