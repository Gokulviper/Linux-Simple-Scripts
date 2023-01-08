#! /bin/bash
echo ""> aa.txt
x="`wget -qO- --no-check-certificate https://creatorapp.zohopublic.com/site24x7/location-manager/json/IP_Address_View/C80EnP71mW2fDd60GaDgnPbVwMS8AGmP85vrN27EZ1CnCjPwnm0zPB5EX4Ct4q9n3rUnUgYwgwX0BW3KFtxnBqHt60Sz1Pgntgru `"
x=`echo $x | sed 's/}/\\n/g' `
  n_ipv6=1
n_city=1
for ip in ${x[@]};
do 
# ipv6=`echo $ip | sed 's/,/\\n/g' | grep "IPv6_Address_External"|sed 's/\<IPv6_Address_External\>//g'`
 ipv6=`echo $ip | sed 's/,/\\n/g' | grep "IPv6_Address_External"|sed 's/\<IPv6_Address_External\>//g'|tr -d '{""'|tr -d ':""'`
ipv6=`echo $ipv6|tr -d '{""'`
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
        echo "\"ipv6_prefix\":\"$n_ipv6\",">>aa.txt
        echo "\"region\":\"$n_city\",">>aa.txt
        echo "\"service\":\"site24x7\",">>aa.txt
        echo "\"network_border_group\":\"$n_city\"">>aa.txt
       
        echo "}," >>aa.txt
        n_ipv6=1
        n_city=1
     fi
     fi
done