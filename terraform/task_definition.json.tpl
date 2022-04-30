[
   {
      "essential": true,
      "name":"orca-app",
      "image":"${REPOSITORY_URL}",
      "portMappings":[
         {
            "containerPort":5000,
            "hostPort":5000,
            "protocol":"tcp"
         }
      ],
      "environment":[
         {
            "name":"POSTGRES_USER",
            "value":"${POSTGRES_USERNAME}"
         },
         {
            "name":"POSTGRES_PASSWORD",
            "value":"${POSTGRES_PASSWD}"
         },
         {
            "name":"DATABASE_URL",
            "value":"${DATABASE_URL}"
         },
         {
            "name":"POSTGRES_DATABASE",
            "value":"${POSTGRES_DATABASE}"
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