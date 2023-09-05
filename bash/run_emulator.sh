#!/bin/bash

HAS_AVD=false
BURP_FLAG=false
VERBOSE=false
ORIGINAL_SYS=false
EMU_PARAMS=""
EDIT_PARAMS=true

echo "Analyzing options..."

while [[ $# -gt 0 ]]
do
  key=$1

  case $key in
    "burp")
      echo "Burp option detected"
      EMU_PARAMS=$EMU_PARAMS" -http-proxy 127.0.0.1:8080"
      BURP_FLAG=true
      shift
    ;;
    "proxy")
      echo "Proxy option detected"
      if [ "$BURP_FLAG" == "false" ];then
        EMU_PARAMS=$AEMU_PARAMS" -http-proxy "$2
      else
        echo "You are use burp, so proxy is not working!"
      fi
      shift 2
    ;;
    "avd")
      echo "AVD name detected"
      HAS_AVD=true
      AVD_NAME=$2
      shift 2
    ;;
    "tcpdump")
      echo "Tcpdump option detected"
      EMU_PARAMS=$EMU_PARAMS" -tcpdump "$2
      shift 2
    ;;
    "phone")
      echo "Phone number option detected"
      EMU_PARAMS=$EMU_PARAMS" -phone-number "$2
      shift 2
    ;;
    "wipe")
      echo "Wipe data option detected"
      EMU_PARAMS=$EMU_PARAMS" -wipe-data"
      shift
    ;;
    "verbose")
      echo "Verbose option detected"
      VERBOSE=true
      EMU_PARAMS=$EMU_PARAMS" -verbose"
      shift
    ;;
    "sys")
      echo "Use original system image option detected"
      ORIGINAL_SYS=true
      shift
    ;;
   "no_edit")
     echo "No edit emu params option detected"
     EDIT_PARAMS=false
     shift
    ;;
   "help")
     echo -e "Usage this options:\n" \
       "avd - specify AVD name\n" \
       "burp - start emulator with localhost:8080 proxy for BurpSuite\n" \
       "no_edit - disable editing of emulator parameters\n" \
       "proxy \"login:password@host:port\" - specify emulator proxy\n" \
       "phone \"number\" - set phone number to emulator\n" \
       "sys - use original (non-modified) system image\n" \
       "tcpdump \"path/to/dumpfile\" - sniff emulator network traffic to file\n" \
       "verbose - run emulator in verbose mode\n" \
       "wipe - wipe userdata of emulator" 
     exit
    ;;
    *)
      echo "Unexpeted parameter "$key
      shift
    ;;
  esac
done

if [ "$HAS_AVD" == "false" ]; then
  echo -e "\nAvailable AVDs:"
  emulator -list-avds
  read -p "Enter AVD: " AVD_NAME
  echo ""
fi

emu_info=$(avdmanager list avd | grep -A 2 $AVD_NAME | tail -n1)
version=$(echo $emu_info | grep -Po "Android \d{2}\.\d" | grep -Po "\d{2}\.\d")
android_abi=${emu_info##*/}

android_api=""
case $version in
  "10.0")
    android_api="android-29"
  ;;
  "11.0")
    android_api="android-30"
  ;;
  "*")
    echo "Detect unsupported version of Android!"
    exit
  ;;
esac

if [ "$ORIGINAL_SYS" == "false" ]; then
  EMU_PARAMS=$EMU_PARAMS" -system $HOME/work/android/emulator_images/$android_api/$android_abi/system.img"
fi

EMU_PARAMS=$EMU_PARAMS" -writable-system -delay-adb -no-audio -no-boot-anim -ranchu -no-snapstorage -avd $AVD_NAME"

if [ "$EDIT_PARAMS" == "true" ]; then
  succ_flag=false

  while [ "$succ_flag" == "false" ]
  do
    echo -e "Current parameters of emulator:\n\n$EMU_PARAMS\n\nDo you have edit this? [y/N] "
    read -n1 choice
    case $choice in
      "" | n | N)
        succ_flag=true
      ;;
      y | Y)
        succ_flag=true
        read -e -p "Edit: " -i "$EMU_PARAMS" EMU_PARAMS
      ;;
      *)
        echo "Wrong answer!"
      ;;
    esac
  done
else
  echo -e "\nEnd params:\n$EMU_PARAMS"
fi

if [ "$VERBOSE" == "true" ]; then
  emulator $EMU_PARAMS
else
  emulator $EMU_PARAMS > /dev/null 2>&1 &
fi

echo "Emulator was started..."

