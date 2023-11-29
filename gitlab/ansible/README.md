# Projeto responsável por criar uma instância de Gitlab-Runner com Ansible.

### Install Runner Docker Gitlab

#### (runner-docker)

ansible-playbook -i inventory.cfg runner_docker_install.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

### Adiciona Runner Shell Gitlab

#### (runner-shell)

ansible-playbook -i inventory.cfg runner_shell_install.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

### Install Kubectl Gitlab

ansible-playbook -i inventory.cfg kubectl_install.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

### Install Cliente AWS

ansible-playbook -i inventory.cfg aws_cli_install.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

### Configure AWS

ansible-playbook -i inventory.cfg aws_configure.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu

### Kube Config

ansible-playbook -i inventory.cfg kubeconfig_install.yml -b --private-key /Users/tomrlh/Documents/Programming_Projects/DevOps/gitlab-fullrelease/aws/terraform/EC2/id_rsa -u ubuntu
