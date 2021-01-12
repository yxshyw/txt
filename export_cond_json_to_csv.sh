#!/bin/bash

head='vin,veh_series,event_code,send_type,pkg_ts,recv_ts,V048,E001,V019,V015,E008,E009,E010,V018,V034,V053,GPS002,GPS003,V017,E056,E059,E062,E065,E010,V055,V052'
signal=$(sed -e 's/\s*//g' -e 's/^/.data.\\"/g' -e 's/$/\\".val/g' signal|awk 'BEGIN{ORS=","}{print $1}'|sed 's/,$//g')
cmd="'[$signal]|join(\",\")'"
echo $cmd
while read vin;do
  #ls /data6/*/2019/5/1/*$vin* && zcat /data6/*/2019/5/1/*$vin*|./jq-linux64 -r '[.vin,.event_code,.V125]|join(",")'
  while read datatime;do
    month=$(echo ${datatime:4:2}|sed 's/^0//g')
    day=$(echo ${datatime:6:2}|sed 's/^0//g')
#   echo $month,$day,$vin
    ls /data6/condition_data/120vin/2019/$month/$day/cond_${vin}_$datatime.data.gz && \
    zcat /data6/condition_data/120vin/2019/$month/${day}new/cond_${vin}_$datatime.data.gz|./jq-linux64 -r "[.vin,.veh_series,.event_code,.send_type,.pkg_ts,.recv_ts,.data.\"V048\".val,.data.\"E001\".val,.data.\"V019\".val,.data.\"V015\".val,.data.\"E008\".val,.data.\"E009\".val,.data.\"E010\".val,.data.\"V018\".val,.data.\"V034\".val,.data.\"V053\".val,.data.\"GPS002\".val,.data.\"GPS003\".val,.data.\"V017\".val,.data.\"E056\".val,.data.\"E059\".val,.data.\"E062\".val,.data.\"E065\".val,.data.\"E010\".val,.data.\"V055\".val,.data.\"V052\".val]|join(\",\")" |sed "1i$head"|gzip -f > ./csv5/$vin.$datatime.csv.gz
  done < datatime
done < vin
