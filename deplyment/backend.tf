terraform {
  backend "s3" {
    bucket = "devops-kunalb-23"
    key    = "freya/deployment.tfstate"
    region = "ap-south-1"
  }
}