resource "aws_cloudwatch_metric_alarm" "ecs_CPUUtilization" {
  alarm_name                = "ecs_CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "80"
  alarm_description         = "The percentage of CPU units that are used in the cluster or service. Cluster CPU utilization (metrics that are filtered by ClusterName without ServiceName) is measured as the total CPU units in use by Amazon ECS tasks on the cluster, divided by the total CPU units that were registered for all of the container instances in the cluster. Only container instances in ACTIVE or DRAINING status will affect CPU utilization metrics. Cluster CPU utilization metrics are only used for tasks using the EC2 launch type. Service CPU utilization (metrics that are filtered by ClusterName and ServiceName) is measured as the total CPU units in use by the tasks that belong to the service, divided by the total number of CPU units that are reserved for the tasks that belong to the service. Service CPU utilization metrics are used for tasks using both the Fargate and the EC2 launch type. Unit: Percent."
  alarm_actions             = [aws_sns_topic.orca-app-topic.arn]
  ok_actions                = [aws_sns_topic.orca-app-topic.arn]
  insufficient_data_actions = []
  
}

resource "aws_cloudwatch_metric_alarm" "ecs_MemoryUtilization" {
  alarm_name                = "ecs_MemoryUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "80"
  alarm_description         = "The percentage of memory that is used in the cluster or service. Cluster memory utilization (metrics that are filtered by ClusterName without ServiceName) is measured as the total memory in use by Amazon ECS tasks on the cluster, divided by the total amount of memory that was registered for all of the container instances in the cluster. Only container instances in ACTIVE or DRAINING status will affect memory utilization metrics. Cluster memory utilization metrics are only used for tasks using the EC2 launch type. Service memory utilization (metrics that are filtered by ClusterName and ServiceName) is measured as the total memory in use by the tasks that belong to the service, divided by the total memory that is reserved for the tasks that belong to the service. Service memory utilization metrics are used for tasks using both the Fargate and EC2 launch types. . Unit: Percent."
  alarm_actions             = [aws_sns_topic.orca-app-topic.arn]
  ok_actions                = [aws_sns_topic.orca-app-topic.arn]
  insufficient_data_actions = []
  
}

resource "aws_cloudwatch_metric_alarm" "loadbalancer_UnHealthyHostCount" {
  alarm_name                = "loadbalancer_UnHealthyHostCount"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "UnHealthyHostCount"
  namespace                 = "AWS/NetworkELB"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "The number of targets that are considered unhealthy."
  alarm_actions             = [aws_sns_topic.orca-app-topic.arn]
  ok_actions                = [aws_sns_topic.orca-app-topic.arn]
  insufficient_data_actions = []
  
}

resource "aws_cloudwatch_metric_alarm" "loadbalancer_ClientTLSNegotiationErrorCount" {
  alarm_name                = "loadbalancer_ClientTLSNegotiationErrorCount"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ClientTLSNegotiationErrorCount"
  namespace                 = "AWS/NetworkELB"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "The total number of TLS handshakes that failed during negotiation between a client and a TLS listener."
  alarm_actions             = [aws_sns_topic.orca-app-topic.arn]
  ok_actions                = [aws_sns_topic.orca-app-topic.arn]
  insufficient_data_actions = []
  
}

resource "aws_cloudwatch_metric_alarm" "loadbalancer_TargetTLSNegotiationErrorCount" {
  alarm_name                = "loadbalancer_TargetTLSNegotiationErrorCount"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "TargetTLSNegotiationErrorCount"
  namespace                 = "AWS/NetworkELB"
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "The total number of TLS handshakes that failed during negotiation between a TLS listener and a target."
  alarm_actions             = [aws_sns_topic.orca-app-topic.arn]
  ok_actions                = [aws_sns_topic.orca-app-topic.arn]
  insufficient_data_actions = []
  
}


