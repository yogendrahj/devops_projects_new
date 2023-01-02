#!/bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
TOKEN="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"
cd /home/ec2-user && git clone https://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
@github.com/yogendrahj/devops_projects_new/tree/main/phonebook-microservice-project
python3 /home/ec2-user/phonebook/phonebook-app.py