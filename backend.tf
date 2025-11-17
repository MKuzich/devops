# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-bucket-mkuzich-1"
#     key            = "lesson-5/terraform.tfstate"
#     region         = "eu-central-1"
#     encrypt        = true 
#     use_lockfile   = true
#   }
# }