# DevOps Midterm Project - Blue/Green Deployment Pipeline

![Python](https://img.shields.io/badge/python-3.12-blue)
![Flask](https://img.shields.io/badge/flask-2.3-green)
![Terraform](https://img.shields.io/badge/terraform-1.5-purple)
![License](https://img.shields.io/badge/license-MIT-orange)

## 📦 Project Structure

devops_midterm/
├── .github/
│ └── workflows/ # GitHub Actions CI/CD
│ └── cl.yml # Deployment workflow
├── deploy/ # Blue-Green environments
│ ├── blue/ # Production (v1.0)
│ │ ├── templates/ # Blue templates
│ │ └── app.py # Production Flask app
│ ├── green/ # Staging (v1.1)
│ │ ├── templates/ # Green templates
│ │ └── app.py # Staging Flask app
│ └── live/ # Active deployment (symlink)
│ ├── templates/
│ └── app.py
├── src/ # Development files
│ ├── templates/ # Dev templates
│ └── app.py # Main application
├── terraform/ # Infrastructure code
│ └── main.tf # Terraform config
├── .gitignore
├── deploy.bat # Deployment script
├── monitor.bat # Health monitor
├── README.md
├── requirements.txt # Python dependencies
└── rollback.bat # Rollback script


## 🚀 Quick Start
```bash
# 1. Initialize environment
terraform -chdir=terraform apply

# 2. Start deployment
deploy.bat  # Auto-opens http://localhost:5000


    A[Start] --> B{Health Check Green:5000}
    B -->|Success| C[Switch live→green]
    B -->|Failure| D[Rollback to blue]

File	          Purpose
deploy.bat	    Switches traffic to green environment
rollback.bat	Emergency revert to blue
monitor.bat  	Logs health status to monitor_log.txt


Terraform configuration

resource "local_file" "blue_env" {
  filename = "../blue_env/app.py"
  content  = file("../app.py") 
}
    Creates identical blue/green environments

    Installs Python if missing

Testing

python test_app.py  # Runs unit tests
curl http://localhost:5000/health  # Manual health check

Troubleshooting

1.Symlink Permission Errors: (almost killed me)
    Enable Developer Mode in Windows Settings

    Run scripts as Administrator

2.Port Conflicts: (my fault forgot change)
netstat -ano | findstr 5000
taskkill /pid [PID] /f

3.Health Check Fails:
Verify app runs manually first:
python blue_env\app.py


