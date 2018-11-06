# PowerShell_AWS_EBS_EIP_SQLServer_Automation

AWS managed services come with a lot of advantages such as less administration cost, scalability and availability but sometimes we need to have control over our database server's operating system. This means that we are in charge of security and managing our database server as well as getting it ready for use.

Assume you have a legacy app that requires a SQL Server database and you want to migrate it to AWS. 

Bootstrapping is one way of automating this task using user data during boot time or we can create a Scheduled Task in our custom AMI that starts this PowerShell script afterwards. The script retrieves the instance-id from meta-data and attaches the database drive (EBS) to the server (your .mdf and ldf files are here).
In this case we are also going to attach a public IP address (EIP) to the instance. We could put the database server in a private subnet that only accepts traffic from your server but that requires you to change the database endpoint in your app. At the end the server restarts the SQL Server service and it is ready to serve traffic.
