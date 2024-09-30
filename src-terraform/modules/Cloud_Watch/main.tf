# Alarme para a CPUUtilization
resource "aws_cloudwatch_metric_alarm" "Prod_alarmCpu" {
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

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Alarme de leitura para o EBS
resource "aws_cloudwatch_metric_alarm" "Prod_alarmEbsReadOps" {
  alarm_name                = "EBS_Volume_ReadOps_Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "VolumeReadOps"
  namespace                 = "AWS/EBS"
  period                    = 120
  statistic                 = "Sum"
  threshold                 = 80
  alarm_description         = "Este alarme monitora as operações de leitura do volume EBS"
  insufficient_data_actions = []

  dimensions = {
    VolumeId = var.ebs_volume_id
  }
}

# Alarme de escrita para o EBS
resource "aws_cloudwatch_metric_alarm" "Prod_alarmEbsWriteOps" {
  alarm_name                = "EBS_Volume_WriteOps_Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "VolumeWriteOps"
  namespace                 = "AWS/EBS"
  period                    = 120
  statistic                 = "Sum"
  threshold                 = 80
  alarm_description         = "Este alarme monitora as operações de escrita no volume EBS"
  insufficient_data_actions = []

  dimensions = {
    VolumeId = var.ebs_volume_id
  }
}

#Criação do DashBoard para as três métricas
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
            ["AWS/EC2", "CPUUtilization", "InstanceId", "i-00f185cb92a977fc1"]
          ],
          period = 300,
          stat   = "Average",
          region = "us_east_1",
          title  = "EKS Cluster _ CPU Utilization"
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
          region = "us_east_1",
          title  = "EKS Cluster _ Storage (EBS) Operations"
        }
      },
    ]
  })
}
