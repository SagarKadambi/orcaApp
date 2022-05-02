# Orca App
A python service that logs unique access to the service. The service uses PostgreSQL as a datastore
and expects the URL and the credentials to be passed in the DATABASE_URL environment
variable.
The service itself has 2 endpoints (in app.py), one for the service itself and the other
one for the healthcheck.

## Architecture
![Architecture](orcaApp_design.png)

The service runs on docker containers in ECS Fargate. It is deployed in us-east-2 in 2 different subnets. It is front-ended by an application load balancer which is made public facing by an internet gateway.
There is an instance of PostgreSQL database hosted in RDS.

## Workflows
I have used github actions/workflows to the handle CI/CD for this service. Only a successful completion of one workflow will lead to the execution of the next, as dependencies have been set. The following are the main actions :
- Build : The app is built with dependencies and the corresponding docker image is pushed to AWS ECR. The image is tagged with the sha of the commit (as i was unable to get the branch name consistently).
- Static Analysis : Empty workflow for now. A suitable tool like Sonarqube can be used for static analysis.
- Terraform deploy to Test environment : The given AWS account is used as "test" environment. This workflow deploys everything in the "terraform" folder.
- Integration Tests : Empty for now.
- Terraform deploy to Prod environment : Have set the same AWS account as prod. Ideally would implement Rolling update with a suitable minimum healthy percent.
- End to end tests : Empty for now. End to end tests can be put in place to be sure the app is healthy.
## Improvements
Due to time/other constraints, a lot of what could not be achieved as part of this exercise have been listed in the [Improvements Doc](Orca_Improvements.docx).