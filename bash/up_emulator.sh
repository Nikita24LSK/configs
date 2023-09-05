#!/bin/bash

USE_PROXY=false
APP=false
USE_EMU_PARAMS=false
REMOUNT_FS=false
START_FRIDA=false
START_OBJECTION=false
AVD_NAME_FLAG=false

echo "Analyzing options..."

while [[ $# -gt 0 ]]
do
  key=$1

  case $key in
    "emu_params")
      echo "Using additional emulator params detected"
      USE_EMU_PARAMS=true
      EMU_PARAMS=$2
      shift 2
    ;;
    "proxy")
      echo "Using proxy data detected"
      USE_PROXY=true
      PROXY_HOST=$2
      PROXY_PORT=$3
      PROXY_LOGIN=$4
      PROXY_PASSWORD=$5
      shift 5
    ;;
    "app")
      echo "Installing app detected"
      APP=true
      APP_PATH=$2
      shift 2
    ;;
    "frida")
      START_FRIDA=true
      shift
    ;;
    "remount")
      echo "Remount fs after loading emulator option detected"
      REMOUNT_FS=true
      shift
    ;;
    "objection")
      echo "Objection option detected"
      START_OBJECTION=true
      shift
    ;;
    "avd")
      echo "Avd name option detected"
      AVD_NAME_FLAG=true
      AVD_NAME=$2
      shift 2
    ;;
    "help")
      echo -e "Usage this options:\n" \
        "avd - specify avd name\n" \
        "emu_params - specify additional params of script start_emulator in double brackets\n" \
        "proxy - run redsocks proxy after launching of emulator\n" \
        "app - install application after booting of emulator\n" \
        "frida - start frida server after booting of emulator\n" \
        "remount - remount filesystem of emulator\n" \
        "objection - start objection with installed app"
        exit
    ;;
    *)
      echo "Unexpected option "$key
      shift
    ;;
  esac
done

echo -e "\nRun script start_emulator.sh"
if [ "$AVD_NAME_FLAG" == "true" ]; then
  echo $AVD_NAME | run_emulator no_edit $EMU_PARAMS
else
  run_emulator no_edit $EMU_PARAMS
fi

echo -e "\nRestart adbd as root..."
adb wait-for-device
adb root

echo -e "\nRunning tweaks..."
adb wait-for-device
adb shell tweaks

if [ "$USE_PROXY" == "true" ]; then
  echo -e "\nSetting proxy..."
  adb wait-for-device
  adb shell proxy $PROXY_HOST $PROXY_PORT $PROXY_LOGIN $PROXY_PASSWORD
fi

if [ "$REMOUNT_FS" == "true" ]; then
  echo -e "\nRemounting fs..."
  adb wait-for-device
  adb remount
fi

if [ "$APP" == "true" ]; then
  echo -e "\nInstalling app..."
  adb wait-for-device
  adb install $APP_PATH
fi

if [ "$START_FRIDA" == "true" ]; then
  echo -e "\nStarting frida server"
  adb wait-for-device
  adb shell frida-server &
fi

