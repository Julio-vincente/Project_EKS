resource "aws_ebs_volume" "EBS_Volume" {
  count = var.volume_count
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type

  tags = {
    Name = "${var.volume_name}-${count.index}"
  }

}

resource "aws_volume_attachment" "EBS_ATT" {
  count        = var.volume_count
  device_name  = var.device_name
  volume_id    = aws_ebs_volume.EBS_Volume[count.index].id
  instance_id  = var.instance_id
  force_detach = false
}