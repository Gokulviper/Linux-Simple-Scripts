#!bin/bash
echo "enter the domain name "
read domain_name
echo "enter total time you monitor the website"
echo "please mention how many hour your script want to be run (if you dont want to interest to mention this time put in 0)"
read hour
echo "please mention how many minute your script want to be run (if you dont want to interest to mention this time put in 0)"
read minute
echo "please mention how many seconds your script want to be run (if you dont want to interest to mention this time put in 0)"
read second
echo "enter the frequency time to monitor "
echo "please mention how many hour your frquency time (if you dont want  to mention this time put in 0)"
read f_hour
echo "please mention how many minute your frquency time (if you dont want  to mention this time put in 0)"
read f_min
echo "please mention how many second your frquency time (if you dont want  to mention this time put in 0)"
read f_sec
f_hourTosec=$((f_hour*3600))
f_minTosec=$((f_min*60))
f_time=$((f_hourTosec+f_minTosec+f_sec))
h_s=$((hour*3600))
m_s=$((minute*60))
total_time=$((h_s+m_s+second))
START_TIME=$(date +%s)
echo "monitoring for your given domain $domain_name is started"
while [ $(( $(date +%s) - $total_time )) -lt $START_TIME ]
do
date >> timingRecord.txt
echo "domain name :" $domain_name >> timingRecord.txt
echo "\n ">>timingRecord.txt
curl -w "dns_time: %{time_namelookup} \n connection time: %{time_connect} \n ssl_handshake_time: %{time_appconnect} \n First byte time: %{time_starttransfer}\n Download time: %{time_total} \n" -o /dev/null -s "$domain_name" >> timingRecord.txt
echo "\n ">>timingRecord.txt
echo "\n ">>timingRecord.txt
echo "\n ">>timingRecord.txt
sleep $f_time
done
echo "task finished you want see the entire data press 1 or exit press any letter"
read key
case $key in
1)cat timingRecord.txt;;
*)thank you have a great day;;
esac
