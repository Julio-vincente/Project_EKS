variable "volume_name" {
  type    = string
  default = "File Storag"

}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "volume_size" {
  type    = number
  default = 10
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "volume_count" {
  type    = number
  default = 1
}

variable "device_name" {
  type    = string
  default = "/dev/xvdf"
}

variable "instance_id" {
  type    = string
  default = "i-00f185cb92a977fc1"
}