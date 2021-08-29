sudo apt update -y


# to check that apache is installed or not
if dpkg --get-selections | grep apache2 ; then
        echo "apache2 is installed"
if service apache2 status; then
        echo "service is running"
        sudo service apache2 restart
fi
else
        sudo apt install apache2
        sudo service apache2 restart
        echo "apache2 is not installed"
fi

#creating the tar file in /tmp/
timestamp=$(date "+%d%m%Y-%H%M%S")
tar -cvf /tmp/sivasankari-httpd-logs-$timestamp.tar /var/log/apache2/*.log
echo "file created $timestamp"

s3_bucket=upgrad-sivasankari
aws s3 cp /tmp/sivasankari-httpd-logs-${timestamp}.tar s3://${s3_bucket}/
echo "copied to s3 bucket"
