# Flask App Deployment on AWS EKS
**Automated Provisioning of a Flask App using Terraform, VPC, EC2, ECR, IAM, and Kubernetes/EKS**

This project leverages Terraform and Github Actions pipelines to provision AWS resources, including VPC components, EC2 instances, Elastic Container Registry (ECR) and IAM roles. Additionally, it orchestrates the deployment of an Amazon Elastic Kubernetes Service (EKS) cluster which, once operational, hosts a Flask application within servers orchestrated by Kubernetes pods. To access the web application a load balancer service is installed and configured to allow external connections.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Deploying the Application](#deploying-the-application)
- [Testing](#testing)
- [Cleanup](#cleanup)


## Project Structure

```
flask-app-deployment-aws-eks/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── flask-app/
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   ├── static/
│   │   └── devops.png
│   └── tests/
│       ├── __init__.py
│       └── test_app.py
├── k8s/
│   └── k8s-deployment.yml
└── terraform/
    ├── ecr.tf
    ├── eks.tf
    ├── main.tf
    ├── outputs.tf
    └── vpc.tf
```

## Prerequisites

- AWS Account with necessary permissions
- AWS CLI configured
- Terraform installed
- Docker installed
- Kubernetes CLI (kubectl) installed
- GitHub account

## Setup Instructions

1. **Clone the repository**:
   ```sh
   git clone https://github.com/your-username/flask-app-deployment-aws-eks.git
   cd flask-app-deployment-aws-eks
   ```

2. **Configure AWS CLI**:
   Ensure your AWS CLI is configured with the necessary access keys and region.

   ```sh
   aws configure
   ```

3. **Initialize Terraform**:
   Navigate to the `terraform/` directory and initialize Terraform.

   ```sh
   cd terraform
   terraform init
   ```

4. **Review and apply Terraform configurations**:
   Apply the Terraform configuration to create the necessary AWS resources.

   ```sh
   terraform apply
   ```

   This will set up the VPC, EKS cluster, and ECR repository.

## Deploying the Application

1. **Build and push Docker image**:
   Navigate to the `flask-app/` directory, build the Docker image, and push it to the ECR repository created by Terraform.

   ```sh
   cd ../flask-app
   docker build -t your-ecr-repo-uri:latest .
   $(aws ecr get-login --no-include-email --region your-region)
   docker push your-ecr-repo-uri:latest
   ```

2. **Deploy to EKS**:
   Apply the Kubernetes deployment configuration to deploy the Flask application to EKS.

   ```sh
   cd ../k8s
   kubectl apply -f k8s-deployment.yml
   ```

## Testing

Run the tests located in the `flask-app/tests` directory to ensure the application is working as expected.

```sh
cd ../flask-app
python -m unittest discover tests
```

## Cleanup

To clean up the AWS resources created by Terraform, navigate to the `terraform/` directory and run:

```sh
terraform destroy
```
