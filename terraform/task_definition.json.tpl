[
   {
      "essential": true,
      "name":"orca-app",
      "image":"${REPOSITORY_URL}",
      "portMappings":[
         {
            "containerPort":80,
            "hostPort":80,
            "protocol":"tcp"
         }
      ],
      "environment":[
         {
            "name":"DATABASE_URL",
            "value":"${DATABASE_URL}"
         }
      ],
      "logConfiguration": {
         "logDriver": "awslogs",
         "options": {
            "awslogs-group" : "${CW_LOG_GROUP}",
            "awslogs-region": "${AWS_REGION}",
            "awslogs-stream-prefix": "orcaApp"
            }
         }
   }
]