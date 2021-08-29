This script is used to copy  the apache2 log files into the AWS s3 bucket
1.Check wether Apache2 is installed or not. If not install Apache2 server
2.Check the status of the Apache2 is in running state
3.If not, restart the apache2 serve
4.copy the .log files from the /var/log/apache2 and create the tar file in /tmp folder
5.Include the time stamp in the tar filename
6.copy the tar file to AWS s3 bucket
