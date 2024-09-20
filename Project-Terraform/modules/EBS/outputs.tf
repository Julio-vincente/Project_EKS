output "VolumeId" {
  description = "Volume Id for EBS"
  value       = aws_ebs_volume.EBS_Volume.id
}
