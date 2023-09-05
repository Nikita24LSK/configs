#!/bin/bash

text=$1
trans=`trans :ru -brief "$text"`
notify-send "Перевод" "$trans"
