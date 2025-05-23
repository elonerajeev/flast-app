# MediaAMP Flask Application with Monitoring and CI/CD Pipeline

This repository contains a comprehensive solution that automates the deployment and monitoring of a Flask application. It leverages **Terraform** for infrastructure provisioning, **Docker** for containerization, **Jenkins** for CI/CD, and **Prometheus** with **Node Exporter** for system monitoring. The project demonstrates how to integrate these tools seamlessly to build a robust, scalable, and efficient deployment pipeline.

---

## Features

- **Flask application** running in a Docker container
- Automated **infrastructure provisioning** using Terraform on AWS
- **Continuous Deployment (CD)** pipeline set up with Jenkins
- Real-time **system monitoring** with Prometheus and Node Exporter
- **Cron jobs** for scheduled tasks and automations

---

## Architecture Overview

The architecture for this project is as follows:

1. **Flask Application**: The core functionality of the app is implemented in Flask, containerized using Docker for portability. Metrics are exposed for Prometheus monitoring.
2. **Infrastructure Automation (Terraform)**: Terraform automates the provisioning of resources in AWS, such as EC2 instances, security groups, and IAM roles.
3. **CI/CD Pipeline (Jenkins)**: Jenkins automates the building, testing, and deployment process of the Flask app. It pulls the latest code from GitHub and deploys it to the AWS infrastructure.
4. **Monitoring (Prometheus & Node Exporter)**: Prometheus collects application and system-level metrics, which are visualized through Prometheus dashboards. Node Exporter is used for system metrics like CPU usage, memory, and disk I/O.
5. **SystemD Setup**: Ensures the Flask application runs as a service, restarting automatically if it crashes.

---

## Screenshots

### 1. Terraform Code Editor Setup
![Terraform Code Editor Setup](screenshot/Terraform%20Code%20Editor%20Setup.jpeg)

### 2. Docker Installation on EC2 CLI
![Docker Installation on EC2 CLI](screenshot/Docker%20installation%20on%20EC2%20CLI.jpeg)

### 3. Prometheus Running CLI Log
![Prometheus Running CLI Log](screenshot/Prometheus%20%20runing%20CLI%20Log.jpeg)

### 4. Prometheus Main Interface Metrics
![Prometheus Main Interface Metrics](screenshot/Prometheus%20main%20interface%20matric.jpeg)

### 5. Prometheus Running
![Prometheus Running](screenshot/Prometheus%20Run.jpeg)

### 6. Welcome Page Nginx
![Welcome Page Nginx](screenshot/welcome%20page%20nginx.jpeg)

### 7. VM Server (EC2)
![VM Server (EC2)](screenshot/VM%20Server%20(EC2).jpeg)

---

## Setup Instructions

### 1. Infrastructure & Networking

2. Navigate to the `terraform/` directory and initialize Terraform.

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

```bash
terraform destroy
```

---

### 2. Flask App & SystemD Setup

1. Navigate to the `Code/` directory and install the required Python dependencies.

```bash
pip install -r requirements.txt
```

2. Build the Docker image for the Flask application.

```bash
docker build -t flask-app .
```

3. Run the Flask application using Docker.

```bash
docker run -p 5000:5000 flask-app
```

4. Set up SystemD to ensure the Flask app runs as a service. Create a SystemD service file and enable it.

---

### 3. Jenkins Automation (Not Performed)

---

### 4. Crontab & Scheduled Task

1. Navigate to the `crontab/` directory.
2. Set up a cron job to automate periodic tasks. Example:

```bash
* * * * * /path/to/script.sh
```

---

### 5. Prometheus Monitoring Setup

1. Navigate to the `monitoring/` directory.
2. Start Prometheus and Node Exporter using Docker Compose.

```bash
docker-compose up --build
```

3. Access Prometheus at `http://3.108.63.154:9090` to visualize metrics.

Public Ip For EC2 : 3.108.63.154


---

## Directory Structure

```
/Devops-Task
  ├── README.md                  
  ├── Code/                      
  │    ├── app/                  
  │    ├── requirements.txt       
  │    └── wsgi.py               
  ├── terraform/                 
  │    ├── main.tf               
  │    ├── variables.tf          
  │    ├── outputs.tf          
  │    └── provider.tf         
  ├── monitoring/              
  |── Screenshot/
  ├── crontab/ 
  │    └── my-cron-script.sh   
  └── .gitignore               
```

---

#
