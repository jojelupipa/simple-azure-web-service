# simple-azure-web-service

Test project to create a Web Service hosted in Azure, which connects to a DB to return some data. This app should only be accessible under a VPN connection using some authentication server such as Radius.

## Planinng

### Resources and budget

Resources required:

- Planning and repo hosting: GitHub - Free
- CI/CD: GitHub Actions
- IaC: Terraform - Free
- Azure Infrastructure:
    - Service principal - Free
    - Resource Group - Free
    - App Service - Free tier
- Authentication service

### SDLC tools

#### Team planning - GitHub

#### Repo hosting - GitHub

Multiple branch approach. Main would have final release, development would have intermediate versions. Adding rules to protect the branches from unintended actions, requiring Pull Requests and approvals to merge and blocking from removing or directly pushing to main branch(es).

Multiple branch approach sample:

main <-- development <-- feature

#### Setting up infrastructure with Terraform

Automatically create the necessary resources for this project with Terraform + GitHub actions. You'll need to connect the pipeline to your subscription.

**Requirements:**

1. Create a service principal to authenticate against Azure

```bash
az ad sp create-for-rbac --name "github-terraform" --role Contributor --scopes /subscriptions/<my-subscription-id> 
```

> This will return the credentials of the sp in JSON format

2. Add the credentials to the repo list of secrets for GitHub Actions.
3. Add secret for SQL server to create in the settings as well.
4. Now you can refer to these on your CI/CD to create resources in Azure.

