🧩 Overview

This project automates the deployment of a Flask backend and Express frontend using Terraform in three different configurations:

    Part 1 – Deploy both apps on a single EC2 instance

    Part 2 – Deploy each app on separate EC2 instances

    Part 3 – Deploy both apps as Docker containers using ECS + ALB

🧱 Prerequisites

    AWS Account with access/secret key

    AWS CLI configured (aws configure)

    Terraform v1.5+

    Docker (for building images)

    S3 bucket for Terraform backend (for Part 3)

📂 Directory Structure

deployment/
│
├── part1-single-ec2/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── user_data.sh
│
├── part2-two-ec2/
│   ├── main.tf
│   ├── vpc.tf
│   ├── ec2_flask.tf
│   ├── ec2_express.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── user_data_flask.sh
│   ├── user_data_express.sh
│
├── part3-ecs-docker/
│   ├── main.tf
│   ├── vpc.tf
│   ├── ecs.tf
│   ├── alb.tf
│   ├── security.tf
│   ├── ecr.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── docker/
│   │   ├── flask/
│   │   │   ├── Dockerfile
│   │   │   └── app.py
│   │   └── express/
│   │       ├── Dockerfile
│   │       └── server.js

⚙️ Common Variables (all parts)

You can define the following in terraform.tfvars:

aws_region     = "us-east-1"
access_key     = "YOUR_AWS_ACCESS_KEY"
secret_key     = "YOUR_AWS_SECRET_KEY"

🚀 Part 1: Flask & Express on Single EC2
🔧 Setup

    A single EC2 instance is provisioned.

    Flask runs on port 5000, Express on port 3000.

    Apps are started using a shell script in user_data.sh.

▶️ Commands

cd part1-single-ec2/
terraform init
terraform apply

📎 Outputs

    Public IP or DNS of the EC2 instance.

    Access Express at http://13.60.24.237:3000

    Access Flask at http://13.60.24.237:5000

🚀 Part 2: Flask & Express on Separate EC2 Instances
🔧 Setup

    Creates a VPC, subnets, and two EC2 instances.

    Security groups allow internal communication and public access.

    Each EC2 runs one app, started via user_data_flask.sh and user_data_express.sh.

▶️ Commands

cd part2-two-ec2/
terraform init
terraform apply

📎 Outputs

    Public IPs for both instances.

    Access Flask at http://13.51.146.211:5000

    Access Express at http://16.171.144.245:3000

🚀 Part 3: Flask & Express using Docker + ECS
🔧 Setup

    Creates:

        ECR repositories for Flask and Express

        VPC, subnets, and security groups

        ECS Cluster using Fargate

        Application Load Balancer with path-based routing

📦 Docker Image Build & Push

# Flask
cd part3-ecs-docker/docker/flask/
docker build -t flask-backend .
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker tag flask-backend <account-id>.dkr.ecr.<region>.amazonaws.com/flask-backend-repo
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/flask-backend-repo

# Express
cd ../express/
docker build -t express-frontend .
docker tag express-frontend <account-id>.dkr.ecr.<region>.amazonaws.com/express-frontend-repo
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/express-frontend-repo

▶️ Terraform Deploy

cd part3-ecs-docker/
terraform init
terraform apply

📎 Outputs

    ALB DNS URL for external access

    Visit:

        http://<alb-dns>/api → Flask

        http://<alb-dns>/ → Express

📤 Clean Up

terraform destroy

📝 Notes

    Use terraform plan before every apply.

    Part 3 uses ALB path routing for services. Make sure ECS task definitions are configured properly.

    Define proper IAM roles for ECS and ECR.

    Don’t forget to open ports in Security Groups as required:

        EC2 (22, 5000, 3000)

        ALB (80)