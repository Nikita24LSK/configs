#!/bin/bash

CUSTOM_IMAGES_DIR=$ANDROID_HOME/custom_images
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
    "timezone")
      echo "Timezone option detected"
      EMU_PARAMS=$EMU_PARAMS" -timezone "$2
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
   "dns")
      echo "DNS option detected"
      EMU_PARAMS=$EMU_PARAMS" -dns-server "$2
      shift 2
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
       "dns \"dns-server-address\" - use custom DNS server\n" \
       "no_edit - disable editing of emulator parameters\n" \
       "proxy \"login:password@host:port\" - specify emulator proxy\n" \
       "phone \"number\" - set phone number to emulator\n" \
       "sys - use original (non-modified) system image\n" \
       "timezone - set timezone\n" \
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

IFS_DEFAULT=$IFS
IFS="---------"

all_avds=($(avdmanager list avd))
for i in "${all_avds[@]}"; do
  if [ "$(grep "Name: $AVD_NAME" <<< $i)" != "" ]; then
    avd_info=$(grep -E "Based on:.+" <<< $i)
    android_version=$(awk 'match($5, /[^\(\)"]+/) {print substr($5, RSTART, RLENGTH)}' <<< $avd_info)
    tag_abi=$(awk '{print $7}' <<< $avd_info)
    avd_tag=${tag_abi%%/*}
    avd_abi=${tag_abi##*/}
    break 
  fi
done

IFS=$IFS_DEFAULT

android_api=""
case $android_version in
  "P")
    android_api="android-28"
  ;;
  "Q")
     android_api="android-29"
  ;;
  "R")
     android_api="android-30"
  ;;
  "S")
     android_api="android-31"
  ;;
  "Sv2")
     android_api="android-32"
  ;;
  "*")
    echo "Detect unsupported version of Android!"
    exit
  ;;
esac

if [ "$ORIGINAL_SYS" == "false" ]; then
  EMU_PARAMS=$EMU_PARAMS" -system $CUSTOM_IMAGES_DIR/$android_api/$avd_tag/$avd_abi/system.img"
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

