#!/bin/env bash

function check_prev_ws() {
  if [[ "$1" == "0" ]]; then
    echo $(cat $CACHE_FILE)
  else
    echo $1
  fi
}

function get_current_ws() {
  echo $(hyprctl activeworkspace -j | jq '.id')
}

function hypr_exec() {
  hyprctl dispatcher $1 $2
}

function get_workspaces_array() {
  echo $(hyprctl workspaces -j | jq '.[].id')
}

MAX_WS_ID=9
CACHE_FILE=/tmp/ws
ACTION=$1
WORKSPACE=$(check_prev_ws $2)
CURRENT_WORKSPACE=$(get_current_ws)

function main() {
  if [ ! -f $CACHE_FILE ]; then
    $(get_current_ws) > $CACHE_FILE
  fi

  if [[ "$ACTION" == "" || "$WORKSPACE" == "" ]]; then
    exit
  fi

  if [[ "$WORKSPACE" == "$CURRENT_WORKSPACE" ]]; then
    exit
  fi

  case $ACTION in
    "workspace")
      echo $CURRENT_WORKSPACE > $CACHE_FILE
      ;;
    "movetoworkspace")
      if [[ ! "$WORKSPACE" =~ special:.+$ ]]; then
        echo $CURRENT_WORKSPACE > $CACHE_FILE
      fi
      ;;
    "movetoworkspacesilent")
      if [[ ! "$WORKSPACE" =~ special:.+$ ]]; then
        if [[ "$WORKSPACE" == "empty" ]]; then
          ws_state=($(get_workspaces_array))
        else
          echo $WORKSPACE > $CACHE_FILE
        fi
      fi
      ;;
    "togglespecialworkspace")
      ;;
    *)
      exit
      ;;
  esac

  hypr_exec $ACTION $WORKSPACE > /dev/null

  if [[ "$ACTION" == "movetoworkspacesilent" && "$WORKSPACE" == "empty" && "$ws_state" != "" ]]; then
    cur_state=($(get_workspaces_array))

    for i in ${cur_state[@]}; do
      if [[ ! "${ws_state[@]}" =~ "$i" ]]; then
        echo $i > $CACHE_FILE
        break
      fi
    done
  fi
}

main

