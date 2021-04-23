aws credentials are stored in ~/.aws/credentials. Terraform will use them
on mac terraform may be moved to /usr/local/bin/
Within each region, there are multiple isolated datacenters
known as Availability Zones (AZs)

user_data:
```
sudo amazon-linux-extras install nginx1 -y
echo 'Hello' > /usr/share/nginx/html/index.html 
sudo systemctl start nginx
```
You need specify outbound rules for a security group in order to install something

To allow you to make your code more DRY and more configurable, Terraform allows you to define input variables.


