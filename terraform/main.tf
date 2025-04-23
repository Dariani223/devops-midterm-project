terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.1"
    }
    null ={
       source = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}

provider "local" {}
provider "null" {}

resource "null_resource" "windows_setup" {
  provisioner "local-exec" {
    command = <<EOT
      # Create directories
      if (!(Test-Path "${path.module}\\..\\blue_env")) {
        New-Item -Path "${path.module}\\..\\blue_env" -ItemType Directory
      }
      if (!(Test-Path "${path.module}\\..\\green_env")) {
        New-Item -Path "${path.module}\\..\\green_env" -ItemType Directory
      }

      # Install Python using winget (if not present)
      if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Output "Installing Python..."
        winget install -e --id Python.Python.3
      } else {
        Write-Output "Python is already installed."
      }
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "local_file" "blue_env" {
  filename = "${path.module}/../blue_env/app.py"
  content  = file("${path.module}/../app.py")
}

resource "local_file" "green_env" {
  filename = "${path.module}/../green_env/app.py"
  content = file("${path.module}/../app.py")
}
