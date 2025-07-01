# Example: Using with AWS security group to allow your current IP
module "my_ip" {
  source = "atrull/getmyip/overbuilt"
}

resource "aws_security_group" "allow_my_ip" {
  name_prefix = "allow-my-ip-"
  description = "Allow access from my current public IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${module.my_ip.ipv4}/32"]
    description = "SSH access from my current IP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${module.my_ip.ipv4}/32"]
    description = "HTTPS access from my current IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "allow-my-current-ip"
    ManagedBy = "terraform"
    MyIP      = module.my_ip.ipv4
  }
}

output "security_group_id" {
  value = aws_security_group.allow_my_ip.id
}

output "allowed_ip" {
  value = module.my_ip.ipv4
}