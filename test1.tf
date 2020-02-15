provider "aws" {
access_key = "AKIAWKKCMNNPPEE2NONT"
secret_key = "SECRET_KEY"
region = "us-east-1"
}

#resources => plans
resource "aws_instance" "my_Ubuntu" {
  count= 1
  ami="ami-0400a1104d5b9caa1"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group.id]
   
  tags={
    Name= "My Ubuntu server"
    Owner = "ildevelop"
    Project="Terraform tutorial "
  }
  # bootraping  
   #user_data = file("user_data.sh")
   user_data = templatefile("user_data.sh.tpl",{
     username="ildevelop"
     names=["John", "Bob", "Max"]
   })
}
resource "aws_security_group" "security_group" {
  name        = "WebServer Security Group "
  description = "Allow TLS inbound traffic"
 # vpc_id      = "${aws_vpc.main.id}"

# create dynamic ingress 
  
dynamic "ingress" { 
   for_each = ["80","443","8080"]
   content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
  }
  /* ingress { # incoming traffic to server
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] # all connections
  } */

  egress { # outcoming traffic from server
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
   }
}
