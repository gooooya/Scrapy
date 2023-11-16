variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}


variable "common_tag" {
  type        = string
  default     = "t2.micro"
}
