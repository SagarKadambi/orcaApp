resource "aws_sns_topic" "orca-app-topic" {
  name = "orca-app-topic"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.orca-app-topic.arn
  protocol  = "email"
  endpoint  = "sagar.kadambi@gmail.com"
}