variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "ami-065deacbcaac64cf2"
}

variable "region" {
  type        = string
  description = "Region name"
  default = "eu-central-1"


}

variable "vm_count" {
  type = number
  default = 1
  
}

variable "vm_ports" {
  type = list(number)
  default = [  80, 443 ]
  
}
