sudo apt update -y


# to check that apache is installed or not
if dpkg --get-selections | grep apache2 ; then
if service apache2 status; then
	sudo service apache2 restart
fi
else
        sudo apt install apache2
        sudo service apache2 restart
fi

#creating the tar file in /tmp/
timestamp=$(date "+%d%m%Y-%H%M%S")
tar -cvf /tmp/sivasankari-httpd-logs-$timestamp.tar /var/log/apache2/*.log


#to copy the file created to the s3 bucket
s3_bucket=upgrad-sivasankari
aws s3 cp /tmp/sivasankari-httpd-logs-${timestamp}.tar s3://${s3_bucket}/


#to create bookkeeping record
if [[ ! -f /var/www/html/inventory.html ]]
then
        tabs 20  #the tabsize
        echo -e  "Log Type\tTime Created\tType\tSize" > /var/www/html/inventory.html
fi
sizemb=$(ls -lh /tmp/sivasankari-httpd-logs-${timestamp}.tar | awk '{print $5}')
#to append the content to the file >> is used
echo -e "httpd-logs\t$timestamp\ttar\t$sizemb" >> /var/www/html/inventory.html

#to create the cron job that runs for every minute
if [[ ! -f /etc/cron.d/automation ]]
then
	echo "59 * * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
fi



