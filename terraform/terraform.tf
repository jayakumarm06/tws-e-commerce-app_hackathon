terraform {

  backend "s3" {
    bucket       = "tws-terraform-hackathon-s3-backend-02"
    key          = "backend-locking/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}


# resource "aws_s3_bucket" "my_bucket" {
#   bucket        = "tws-terraform-hackathon-s3-backend-01"
#   force_destroy = true # Tells Terraform to wipe all objects and versions upon deletion

#   tags = {
#     Name        = "terraform_tfstate"
#     Environment = "dev"
#   }
# }

