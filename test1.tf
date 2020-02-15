provider "aws" {
access_key = "AKIAWKKCMNNPPEE2NONT"
secret_key = "SECRET_KEY"
region = "us-east-1"
}

resource "aws_instance" "my_Ubuntu" {
ami="ami-0400a1104d5b9caa1"
instance_type="t2.micro"
}
