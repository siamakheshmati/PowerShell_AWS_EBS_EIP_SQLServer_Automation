#AWS managed services come with a lot of advantages such as less administration cost, scalibility and availability
#but sometimes we need to have control over our database server's operating system. This means that we are in charge of seurity
#and managing our database server as well as getting it ready for to use.
#Assume you have a legacy app that requires a SQL Server database and you want to migrate it to AWS.

#Bootstraping is one way of automating this task using user data during boot time or we can create a Scheduled Task in
#our cutom AMI that starts this PowerShell script afterwards. The script retrieves the instance-id from meta-data 
#and attaches the database drive (EBS) to the server (your .mdf and ldf files are here).
#In this case we are also going to attach a public IP address (EIP) to the instanceWe could put the database server
#in a private subnet that only accepts traffic from your server but that requires you to change the database endpoint in your app.
#At the end the server restarts the SQL Server service and it is ready to serve traffic.

Here are the steps that you can take in order to automate this process.


#Get the instance-id
$instanceId=Invoke-RestMethod http://169.254.169.254/latest/meta-data/instance-id

#Assign your EIP to the instance
Register-EC2Address -InstanceId $instanceId -PublicIp YOUR_EIP

#Attach your EBS volume to the instance
aws ec2 attach-volume --volume-id YOUR_VOLUME_ID --instance-id $instanceId --device /dev/sdf --region us-west-1

#Restart the SQL Server serive 
Get-service -displayname *SQL* | Where-object {$_.status -eq "running"} |Stop-Service
net start "SQL Server (MSSQLSERVER)" /f /m
