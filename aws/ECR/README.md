## Criação do Registry

aws ecr create-repository --repository-name full-release-ecr --image-tag-mutability IMMUTABLE --image-scanning-configuration scanOnPush=true --region us-east-2

# URI do ECR criado

# 390760239306.dkr.ecr.us-east-2.amazonaws.com/full-release-ecr
