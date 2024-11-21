# Weather App

<img src="https://user-images.githubusercontent.com/25284536/90274607-2535a000-de76-11ea-9d21-ab8c3e68b3a9.png" width="400"> <img src="https://user-images.githubusercontent.com/25284536/90274626-29fa5400-de76-11ea-97a7-c6b67ec2f66a.png" width="400">

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Frontend Setup](#frontend-setup)
  - [Backend Setup](#backend=setup)
  - [Infrastructure Setup](#infrastructure-setup)
- [EC2 Bootstrap Process](#ec2-bootstrap-process)
  - [Ingress](#ingress)
  - [Docker Visualizer](#docker-visualizer)

# Introduction

## Tech Stack

- **Frontend: React, Typescript, Redux, StyledComponents**
- **Backend: Spring Boot**
- **Infrastructure: AWS, Terraform, Jenkins**

## Features

- **Weather forecast for any city**
- **Extended 7 days forecast**
- **Find user location weather by utilizing GeolocationAPI (Note: Due to GeolocationAPI needing HTTPS to work, this functionality works locally but deployed needs a secure domain)**
- **One-click Celcius to Fahrenheit conversion and vice versa**
- **Dark Mode**

# Getting Started

## Backend Setup
First, you need an API key from OpenWeatherMap. You can get one by creating an account on their website. After you get your API key, replace WEATHER_APIKEY with your OpenWeatherMap API Key.

```
SERVER_PORT
SPRING_PROFILES_ACTIVE
WEATHER_APIKEY
SPRING_CLOUD_OPENFEIGN_CLIENT_CONFIG_GEOCODE_URL=http://api.openweathermap.org/geo/1.0
SPRING_CLOUD_OPENFEIGN_CLIENT_CONFIG_WEATHER_URL=https://api.openweathermap.org/data/2.5
```

## Frontend Setup
You will need to add the backend URL.

```
REACT_APP_BACKEND_URL=Backend URL
```

## Infrastructure Setup

### Prerequisites

- AWS CLI must be installed. You can install it from the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- Please create an IAM role and the secret key to get access.
- Configure (weather-app) profile in aws cli locally for terraform.

### Creating the `secrets.tfvars` File

To provide sensitive information such as the path to your VM key pair, create a `secrets.tfvars` file. This file will be used to pass sensitive variables to Terraform commands.

1. **Create a file within the desired environment named `secrets.tfvars`:**

   ```sh
   touch secrets.tfvars
   ```

2. **Add the following content based on the local machine directory path to the `secrets.tfvars` file:**

   ```hcl
   project_name        = "Enter the project name"
   env_name            = "Enter the environment name name"

   VM_KEY_PAIR_PATH = "C:\\Users\\USER\\enter-path\\weather-app-dev-server-key-pair.pem"
   ```

### Using the `secrets.tfvars` File with Terraform Commands

To ensure Terraform uses the variables defined in the `secrets.tfvars` file, use the `-var-file` flag with your Terraform commands.

**Examples**

1. **Initialize Terraform:**

   ```sh
   terraform init
   ```

2. **Plan the Terraform Deployment:**

   ```sh
   terraform plan -var-file="secrets.tfvars"
   ```

3. **Apply the Terraform Deployment:**

   ```sh
   terraform apply -var-file="secrets.tfvars"
   ```

# EC2 Bootstrap Process

### Overview

Automated the setup of the server to deploy the weather app, once you have SSH access to the EC2, perform the following manual steps to complete the setup:

1. **Navigate to the Docker directory and start Docker services using Docker Compose:**

   ```sh
   cd docker/
   docker-compose up -d
   ```
### Architecture Overview

The architecture comprises several layers, each responsible for specific functionalities:

- **Ingress Layer**: Traefik
- **Docker Visualizer Layer**: Portainer

### Ingress

**Tool**: Traefik

- Acts as the entry point for all incoming requests.

### Docker Visualizer

**Tool**: Portainer

- Simplifies Docker management through GUI.

## Credits

- **Frontend was inspired by https://github.com/silent-sea1119/react-weather-app/tree/main**
