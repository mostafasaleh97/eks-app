resource "aws_security_group" "EKS_SG" {
  name        = "eks-sg"
  description = "Allow All inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "eks-sg"
  }
}
