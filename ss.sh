#! /bin/bash
x=`cat ip1.json | sed 's/}/\\n/g'`
create_date="$(date +'%d/%m/%Y %T')" 
echo "{\"created_date\":\"$create_date \",">b.txt
echo "ip_prefix : [" >> b.txt
for ip in ${x[@]};
do
    id=`echo $ip | sed 's/,/\\n/g' | grep "ID"|sed 's/\<ID\>//g'|tr -d ':""'`
    
    city=`echo $ip | sed 's/,/\\n/g' | grep "City"|sed 's/\<City\>//g'|tr -d ':""'`
    place=`echo $ip | sed 's/,/\\n/g' | grep "Place"|sed 's/\<Place\>//g'|tr -d ':""'`
    external_ip=`echo $ip | sed 's/,/\\n/g' | grep "external_ip"|sed 's/\<external_ip\>//g'|tr -d ':""'`
    # echo "{" >> b.txt
    if [[ ! -z $id ]];then
     echo "\"id\":\"$id\"">> id.txt
     fi
 if [[ ! -z $city ]];then
    echo "\"city\":\"$city\"">> city.txt
    fi
 if [[ ! -z $place ]];then
    echo "\"place\":\"$place\"">> place.txt
    fi
 if [[ ! -z $external_ip ]];then
    echo "\"external_ip\":\"$external_ip\"">> external_ip.txt
    fi
    i=0
    while [[  ]]
   
done
echo "]  }" >> b.txt


