variable "availabilityZone" {
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  type        = list(string)
  description = "availability zones for the vpcs"
}
variable "tag" {
  type        = string
  default     = "dg-eks"
  description = "tag name"
}
variable "Accregion" {
  default     = "us-east-1"
  type        = string
  description = "region you are currently working in"
}
variable "desired_size" {
  default = 1
}
variable "max_size" {
  default = 1
}
variable "min_size" {
  default = 1
}