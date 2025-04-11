# CST8918 Final Project: Weather App with Azure AKS

This project demonstrates Infrastructure as Code (IaC) using Terraform to deploy a Remix Weather Application on Azure Kubernetes Service (AKS) with Azure Cache for Redis.

## Project Structure

```
cst8918-final-project/
├── .github/workflows/     # GitHub Actions workflows
├── app/                  # Weather application code
├── infrastructure/       # Terraform code
│   ├── modules/         # Reusable Terraform modules
│   └── environments/    # Environment-specific configurations
└── README.md
```

## Team Members

- [Your Name] (GitHub: [your-github-username])
- [Team Member 2] (GitHub: [their-github-username])
- [Team Member 3] (GitHub: [their-github-username])

## Prerequisites

- Azure CLI
- Terraform
- kubectl
- Docker
- GitHub CLI (optional)

## Setup Instructions

1. Clone the repository
2. Install dependencies
3. Configure Azure credentials
4. Initialize Terraform
5. Apply infrastructure changes

## Infrastructure Components

- Azure Blob Storage (Terraform backend)
- Virtual Network with subnets
- AKS Clusters (test and prod)
- Azure Container Registry
- Azure Cache for Redis
- Kubernetes deployments

## GitHub Actions Workflows

- Static analysis on push
- Terraform plan and tflint on PR
- Automated deployments
- Docker image builds

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Create a pull request
4. Get approval from team members
5. Merge to main branch

## License

[MIT License](LICENSE) 