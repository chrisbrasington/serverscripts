#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#fortune


echo ""
echo "Running: "

service="Plex Media Server"
if (( $(ps -ef | grep -v grep | grep "$service" | wc -l) > 0 ))
then
	echo " Plex - http://$ip:32400/web/index.html"
fi

service=deluged
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
	echo " $service"
else
	$service 
fi

service=deluge-web
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
	echo " $service - https://$ip:8112"
else
	$service --ssl & 
fi

service=steam
if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
	echo " $service"
else
	$service -silent & 
fi

echo " "
echo "Downloads:"
flexget history -s --limit 8 | tail -n 8 | tac | awk  '{ print " " $0 }' 
#flexget history -s 
deluge-console 'info' --sort-reverse=eta | awk '{ print " " $0 }'
echo " "

echo "Online status:"
status=`vpncheck`
echo " $status"
ip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v '10.7.7.3'`
echo " $ip"
echo ""
