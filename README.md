# Orca App
A python service that logs unique access to the service. The service uses PostgreSQL as a datastore
and expects the URL and the credentials to be passed in the DATABASE_URL environment
variable.
The service itself has 2 endpoints (in app.py), one for the service itself and the other
one for the healthcheck.

## Architecture
![Architecture](orcaApp_design.png)

- APP : The service runs on docker containers in ECS Fargate. It is deployed in us-east-2 in 2 different subnets. It is front-ended by an application load balancer which is made public facing by an internet gateway.
- DB : There is an instance of PostgreSQL database hosted in RDS. This is hosted on a private subnet. The credentials for the same can be found in [variables](terraform/variables.tf)
- Autoscaling : Horizontal autoscaling is enabled in ECS based on ECSServiceAverageMemoryUtilization, ECSServiceAverageCPUUtilization and ALBRequestCountPerTarget. More information [here](terraform/autoscaling.tf).
- Alarms : Cloudwatch alarms have been configured on relevant service for relevant metric. The terraform code is located [here](terraform/cloudwatch_alarms.tf)
- Notification : SNS topic and subscription has been set to notify on alarms being triggered. Notifications go out to sagar.kadambi@gmail.com.

## Workflows
I have used github actions/workflows to the handle CI/CD for this service. Only a successful completion of one workflow will lead to the execution of the next, as dependencies have been set. The following are the main actions :
- Build : The app is built with pipenv. The virtual environment with the installed dependencies is copied onto the container. The docker image is pushed to AWS ECR. The image is tagged with the sha of the commit (as i was unable to get the branch name consistently).
- Static Analysis and Security Scan : Empty workflow for now. A suitable tool like Sonarqube can be used for static analysis. Security scan of the docker image can be run on tools like corona/burpsuite for vulnerabilities.
- Terraform deploy to Test environment : The given AWS account is used as "test" environment. This workflow deploys everything in the "terraform" folder.
- Integration Tests : Empty for now.
- Terraform deploy to Prod environment : Have set the same AWS account as prod. Ideally would implement Rolling update with a suitable minimum healthy percent.
- End to end tests : Empty for now. End to end tests can be put in place to be sure the app is healthy.


## Improvements
Due to time/other constraints, a lot of what could not be achieved as part of this exercise have been documented in the [Improvements Doc](Orca_Improvements.docx).