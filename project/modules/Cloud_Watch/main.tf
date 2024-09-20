resource "aws_cloudwatch_metric_alarm" "alarm-julio" {
  alarm_name          = var.metric_name
  comparison_operator = "GreatheThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Avarege"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}