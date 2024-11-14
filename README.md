# simple-azure-web-service

Test project to create a Web Service hosted in Azure, which connects to a DB to return some data. This app should only be accessible under a VPN connection using some authentication server such as Radius.

## Planinng

### Resources and budget

### SDLC tools

Repo hosting - github

#### Considerations

Multiple branch approach. Main would have final release, development would have intermediate versions. Adding rules to protect the branches from unintended actions, requiring Pull Requests and approvals to merge and blocking from removing or directly pushing to main branch(es).

Multiple branch approach sample:

main <-- development <-- feature