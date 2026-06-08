terraform {
  backend "s3" {
    bucket       = "tws-terraform-hackathon-s3-backend-01"
    key          = "backend-locking"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
resource "aws_s3_bucket" "my_bucket" {
  bucket        = "tws-terraform-hackathon-s3-backend-01"
  force_destroy = true # Tells Terraform to wipe all objects and versions upon deletion
}
