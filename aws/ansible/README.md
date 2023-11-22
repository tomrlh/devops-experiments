## Command to init

$ ansible-galaxy init static

### Init the EC2

### Put its IP in inventory.cfg

### Create your task in static/tasks/main.yml

### create a nginx_install.yml in the root with:

- hosts: web
  roles:
  - static

## Installing Nginx

ansible-playbook -i inventory.cfg nginx_install.yml --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

## Connecting via SSH

ssh -i "/Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa" ubuntu@ec2-54-165-14-251.compute-1.amazonaws.com

ssh-agent bash -c 'ssh-add /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa; git clone git@gitlab.com:devops250245/ci-test.git'

ssh-add /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa

git clone git@gitlab.com:devops250245/ci-test.git
