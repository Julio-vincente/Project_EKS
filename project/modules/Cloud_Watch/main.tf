resource "aws_cloudwatch_metric_alarm" "Prod-alarmCpu" {
  alarm_name          = var.metric_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}


resource "aws_cloudwatch_dashboard" "Prod-Dash" {
  dashboard_name = 
  
}