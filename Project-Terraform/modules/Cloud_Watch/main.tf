resource "aws_cloudwatch_metric_alarm" "Prod-alarmCpu" {
  alarm_name                = var.Metric_Name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors EC2 CPU utilization"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_dashboard" "ProdDash" {
  dashboard_name = var.Dash_Name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric",
        x      = 0,
        y      = 0,
        width  = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "i-012345"]
          ],
          period = 300,
          stat   = "Average",
          region = "us-east-1",
          title  = "EKS Cluster - CPU Utilization"
        }
      },
      {
        type   = "metric",
        x      = 0,
        y      = 7,
        width  = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/EBS", "VolumeReadOps", "VolumeId", var.ebs_volume_id],
            [".", "VolumeWriteOps", "VolumeId", var.ebs_volume_id]
          ],
          period = 300,
          stat   = "Sum",
          region = "us-east-1",
          title  = "EKS Cluster - Storage (EBS) Operations"
        }
      },
      {
        type   = "text",
        x      = 0,
        y      = 14,
        width  = 3,
        height = 3,
        properties = {
          markdown = "Hello world"
        }
      }
    ]
  })
}
