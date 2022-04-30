resource "aws_iam_role" "iam_ecs_role" {
  name = "iam_ecs_role"
  assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "Service": "ecs-tasks.amazonaws.com"
       },
       "Action": "sts:AssumeRole"
     }
   ]
 }
EOF

}


resource "aws_iam_role_policy" "iam_orcaApp_policy" {
  name = "iam_orcaApp_policy"
  role = aws_iam_role.iam_ecs_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
              "${aws_cloudwatch_log_group.orcaApp.arn}"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetLifecyclePolicyPreview",
                "ecr:GetDownloadUrlForLayer",
                "ecr:ListTagsForResource",
                "ecr:BatchGetImage",
                "ecr:DescribeImages",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetLifecyclePolicy",
                "ecr:GetRepositoryPolicy",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": ["*"]
        },
        {
          "Effect": "Allow",
          "Action": [
              "ec2:AuthorizeSecurityGroupIngress",
              "ec2:Describe*",
              "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
              "elasticloadbalancing:DeregisterTargets",
              "elasticloadbalancing:Describe*",
              "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
              "elasticloadbalancing:RegisterTargets"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
              "secretsmanager:GetSecretValue"
          ],
          "Resource": "*"
        }
    ]
}
EOF

}