#! /bin/bash
# x=`cat ip1.json | sed 's/}/\\n/g'`
x="`wget -qO- --no-check-certificate https://creatorapp.zohopublic.com/site24x7/location-manager/json/IP_Address_View/C80EnP71mW2fDd60GaDgnPbVwMS8AGmP85vrN27EZ1CnCjPwnm0zPB5EX4Ct4q9n3rUnUgYwgwX0BW3KFtxnBqHt60Sz1Pgntgru `"
x=`echo $x | sed 's/}/\\n/g' `
create_date="$(date +'%d/%m/%Y %T')" 
echo "{\"created_date\":\"$create_date \",">AwsJsonFormat.json
echo "\"prefixes\" : [" >>AwsJsonFormat.json
n_city=1
n_external_ip=1
for ip in ${x[@]};
do
    
    city=`echo $ip | sed 's/,/\\n/g' | grep "City"|sed 's/\<City\>//g'|tr -d ':""'`
    external_ip=`echo $ip | sed 's/,/\\n/g' | grep "external_ip"|sed 's/\<external_ip\>//g'|tr -d ':""'`
    
    if [[ ! -z $city &&  $n_city -eq 1 ]];then
    
        n_city=$city
    
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
        echo "{" >>aa.json
        echo "\"ip_prefix\":\"$n_external_ip\",">>AwsJsonFormat.json
        echo "\"region\":\"$n_city\",">>AwsJsonFormat.json
        echo "\"service\":\"site24x7\",">>AwsJsonFormat.json
        echo "\"network_border_group\":\"$n_city\"">>AwsJsonFormat.json
       
        echo "}," >>AwsJsonFormat.json
        
        n_city=1

        n_external_ip=1
      
    else
        continue
    fi 
done
echo "],">>AwsJsonFormat.json
echo "\"ipv6_prefixes\" : [{" >>AwsJsonFormat.json
n_ipv6=1
n_city=1
for ip in ${x[@]};
do 
    ipv6=`echo $ip | sed 's/,/\\n/g' | grep "IPv6_Address_External"|sed 's/\<IPv6_Address_External\>//g'|tr -d '{""'|tr -d ':""'`
    city=`echo $ip | sed 's/,/\\n/g' | grep "City"|sed 's/\<City\>//g'|tr -d ':""'`
    if [[  ! -z $ipv6  && $ipv6 != 'IP_Address_View[' ]];then
        if [[ ! -z $ipv6 &&  $n_ipv6 -eq 1 ]];then
    
            n_ipv6=$ipv6
    
        fi
        if [[ ! -z $city &&  $n_city -eq 1 ]];then
    
            n_city=$city
    
        fi
        if [[   $n_city != 1 &&    $n_ipv6 != 1 ]];then
        echo "{" >>aa.json
        echo "\"ipv6_prefix\":\"$n_ipv6\",">>AwsJsonFormat.json
        echo "\"region\":\"$n_city\",">>AwsJsonFormat.json
        echo "\"service\":\"site24x7\",">>AwsJsonFormat.json
        echo "\"network_border_group\":\"$n_city\"">>AwsJsonFormat.json
        echo "}," >>AwsJsonFormat.json
        n_ipv6=1
        n_city=1
        fi
    fi
done

echo "] }" >>AwsJsonFormat.json