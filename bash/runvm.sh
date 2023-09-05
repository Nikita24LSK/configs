#!/bin/bash


function main_processor {
	if [[ $list_flag == 1 ]]; then
		if [[ $group_flag == 1 ]]; then
			notify-send -t 4 "Groups List" "$(vboxmanage list groups | tail -n+2 | tr -d \" | awk '{print FNR, $0}')"
		else
			notify-send -t 4 "VMs List" "$(vboxmanage list vms | egrep -o "\".+?\"" | tr -d \" | awk '{print FNR, $0}')"
		fi
	elif [[ $obj_num > 0 ]]; then
		vms_list=($(vboxmanage list vms | egrep -o "\{.+?\}"))


		if [[ $headless_flag == 1 ]]; then
			run_type="headless"
		else
			run_type="gui"
		fi

		if [[ $group_flag == 1 ]]; then
			run_group $vms_list $run_type
		else
			run_one_vm $vms_list $run_type
		fi

	fi
}

function run_group {
	vms_list=$1
	run_type=$2

	groups_list=($(vboxmanage list groups | tail -n+2 | tr -d \"))

	if [[ $obj_num > ${#groups_list[@]} ]]; then
		exit 0;
	fi

	group_name=${groups_list[$obj_num-1]}
	for vm_id in ${vms_list[@]}
	do
		vm_group=$(vboxmanage showvminfo $vm_id | egrep -o "Groups: .+?" | awk '{print $2}')
		if [[ $vm_group == $group_name ]]; then
			vboxmanage startvm --type $run_type $vm_id
		fi
	done
}

function run_one_vm {
	vms_list=$1
	run_type=$2

	if [[ $obj_num > ${#vms_list[@]} ]]; then
		exit 0;
	fi

	vm_id=${vms_list[$obj_num-1]}
	vboxmanage startvm --type $run_type $vm_id
}

function find_vm_number {
	num_re='^[0-9]+$'

	if [[ $1 =~ $num_re ]]; then
		echo $1;
	else
		exit -1;
	fi
}

headless_flag=0
list_flag=0
group_flag=0
obj_num=0

while [[ $# -gt 0 ]]
do
	key=$1

	case $key in
			h|-h|headless|--headless)
					headless_flag=1
					;;
			l|-l|list|--list)
					list_flag=1
					;;
			g|-g|group|--group)
					group_flag=1
					;;
			*)
					obj_num=$(find_vm_number $key)
					;;
	esac

	shift
done

main_processor

