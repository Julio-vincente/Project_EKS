output "ebs_volume_id" {
  description = "ID of the EBS Volume"
  value       = aws_ebs_volume.EBS_Volume[*].id 
}

output "FirstVolumeId" {
  value = aws_ebs_volume.EBS_Volume[0].id
}
