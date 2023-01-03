#!bin/bash
read -p "Enter a domain name: " domain_name


#validate the input numbers
number_pattern='^[0-9]+$'

# If user doesn't enter anything in domain name
while [[ -z "$domain_name" ]]
do
    echo "You must enter a domain"
    read -p "Enter a domain name: " domain_name
done
echo "enter total time you monitor the website"

echo "please mention how many minute your script want to be run (if you dont want to interest to mention this time put in 0)"
read minute
while true
do
	if  [[ $minute =~ $number_pattern ]] ; then
  		break
	else

		echo "please enter  a number "
		read minute
	fi
done

echo "enter the frequency time to monitor "
echo "please mention how many minute your frquency time (if you dont want  to mention this time put in 0)"
read f_min
while true
do
	if  [[ $f_min =~ $number_pattern ]] ; then
  		break
	else

		echo "please enter  a number "
		read f_min
	fi
done
echo "please mention how many second your frquency time (if you dont want  to mention this time put in 0)"
read f_sec
while true
do
	if  [[ $f_sec =~ $number_pattern ]] ; then
		break
	else

		echo "please enter  a number "
		read f_sec
	fi
done
f_hourTosec=$((f_hour*3600))  #converting total run time in seconds
f_minTosec=$((f_min*60))      #converting total min in seconds
f_time=$((f_hourTosec+f_minTosec+f_sec))  #adding all values in seconds
h_s=$((hour*3600))
m_s=$((minute*60))
total_time=$((h_s+m_s+second))
START_TIME=$(date +%s)  #from the epoch time 1970 to till now in seconds
echo "monitoring for your given domain $domain_name is started"
while [ $(( $(date +%s) - $total_time )) -lt $START_TIME ]
do
	date >> timingRecord.txt           #for the current time and date
	echo "domain name :" $domain_name >> timingRecord.txt
	#echo "\n ">>timingRecord.txt
	curl -w "dns_time: %{time_namelookup} \n connection time: %{time_connect} \n ssl_handshake_time: %{time_appconnect} \n First byte time: %{time_starttransfer}\n " -o /dev/			 null -s "https://$domain_name" >> timingRecord.txt
	echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" >>timingRecord.txt
	echo "          ">>timingRecord.txt


	sleep $f_time    #sleeping till next frequency time
done
echo "task finished sucessfully"
echo "want to view entire data press 1"
echo "want to exit press any key"
#after machine finish the task see the record of monitoring
read key
case $key in
1)cat timingRecord.txt;;
*)thank you have a great day;;
esac
