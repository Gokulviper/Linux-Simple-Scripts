#! /bin/bash
create_date="$(date +'%d/%m/%Y %T')" 
echo "{\"created_date\":\"$create_date \",">a.txt
echo " ip_prefix [">>a.txt
jq -c '.[]' ip1.json | sed 's/}/\ \n/g' |while read ip; do
# echo $ip
    id=`echo $ip | sed 's/,/\\n/g' | grep "ID"|sed 's/\<ID\>//g'|tr -d ':""'`
    city=`echo $ip | sed 's/,/\\n/g' | grep "City"|sed 's/\<City\>//g'|tr -d ':""'`
    place=`echo $ip | sed 's/,/\\n/g' | grep "Place"|sed 's/\<Place\>//g'|tr -d ':""'`
    external_ip=`echo $ip | sed 's/,/\\n/g' | grep "external_ip"|sed 's/\<external_ip\>//g'|tr -d ':""'`

    alreadyCidr=0
    c=0
   cidrValue="/32"
    for i in $(seq 1 ${#external_ip})
    do
        if [[ ${external_ip:i-1:1} == "/" ]];then
        c=1
        fi
    done
    if [[ $c == 0 ]];then
    external_ip+=$cidrValue
    fi
    
jq -n --arg id "$id" --arg city "$city" --arg place "$place" --arg external_ip "$external_ip" ' {"ID": $id, "City": $city, "Place": $place, "external_ip": $external_ip }' >>a.txt
echo ",">>a.txt
done
echo "] }">>a.txt
