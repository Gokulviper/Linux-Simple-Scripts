#! /bin/bash
# x=`cat ip1.json | sed 's/}/\\n/g'`
x="`wget -qO- --no-check-certificate https://creatorapp.zohopublic.com/site24x7/location-manager/json/IP_Address_View/C80EnP71mW2fDd60GaDgnPbVwMS8AGmP85vrN27EZ1CnCjPwnm0zPB5EX4Ct4q9n3rUnUgYwgwX0BW3KFtxnBqHt60Sz1Pgntgru `"
x=`echo $x | sed 's/}/\\n/g' `
create_date="$(date +'%d/%m/%Y %T')" 
echo "{\"created_date\":\"$create_date \",">b.txt
echo "ip_prefix : [" >> b.txt
n_id=1
n_city=1
n_place=1
n_external_ip=1;
for ip in ${x[@]};
do
    id=`echo $ip | sed 's/,/\\n/g' | grep "ID"|sed 's/\<ID\>//g'|tr -d ':""'`
    city=`echo $ip | sed 's/,/\\n/g' | grep "City"|sed 's/\<City\>//g'|tr -d ':""'`
    place=`echo $ip | sed 's/,/\\n/g' | grep "Place"|sed 's/\<Place\>//g'|tr -d ':""'`
    external_ip=`echo $ip | sed 's/,/\\n/g' | grep "external_ip"|sed 's/\<external_ip\>//g'|tr -d ':""'`
    
   if [[ ! -z $id  &&   $n_id == 1 ]];then
    
        n_id=$id
   
    fi
    if [[ ! -z $city &&  $n_city -eq 1 ]];then
    
        n_city=$city
    
    fi
    if [[ ! -z $place &&  $n_place -eq 1 ]];then
   
        n_place=$place
    
    fi
    if [[ ! -z $external_ip &&   $n_external_ip == 1 ]];then

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
        n_external_ip=$external_ip
        fi
    
    if [[  $n_id != 1 &&  $n_city != 1 &&  $n_place != 1 &&   $n_external_ip != 1 ]];then
        echo "{" >>b.txt
        echo "\"id\":\"$n_id\",">> b.txt
        echo "\"city\":\"$n_city\",">> b.txt
        echo "\"place\":\"$n_place\",">> b.txt
        echo "\"external_ip\":\"$n_external_ip\",">> b.txt
        echo "}," >> b.txt
        n_id=1
        n_city=1
        n_place=1
        n_external_ip=1
      
    else
        continue
    fi 
done
echo "]  }" >> b.txt


