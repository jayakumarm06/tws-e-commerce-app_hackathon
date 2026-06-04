terraform {
  backend "s3" {
    bucket       = "tws-terraform-hackathon-s3-backend"
    key          = "backend-locking"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
