resource "aws_vpc" "default" {
  
}

resource "aws_subnet" "wp-public-tf" {
    vpc_id            = aws_vpc.default.id
    cidr_block        = var.public_subnet_cidr_block
    availability_zone = "us-west-2a"

    tags = {
       Name = "wp-public-tf"
    }
}

# EC2 Instances

resource "aws_instance" "ec2-instance" {
    ami                         = var.ami
    instance_type               = var.instance_type
    availability_zone           = "us-west-2a"
    subnet_id                   = aws_subnet.wp-public-tf.id
    key_name                    = var.key_name
    associate_public_ip_address = true
    security_groups             = ["var.aws_security_group.wp-sg-tf.id"]
    user_data                   = file("EC2/installing-components.sh")
    tags = {
      Name = "ec2-instance"
    }
}
