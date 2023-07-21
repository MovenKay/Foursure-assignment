
# Create a VPC
resource "aws_vpc" "Foursure" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "Foursure-VPC"
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "Foursure-subnet-pub" {
  vpc_id                  = aws_vpc.Foursure.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "Foursure-subnet-pub"
  }
}

# Create a security group for EC2 instance to allow SSH (port 22) and HTTP (port 80) access
resource "aws_security_group" "Foursure-Security-Group" {
  name_prefix = "Foursure-Security-Group"
  vpc_id      = aws_vpc.Foursure.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#resource "aws_key_pair" "foursure-key" {
 # key_name   = "foursure-key"
 # public_key = file(var.foursure-key)



# Create an EC2 instance
resource "aws_instance" "Foursure-ec2-instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  key_name = var.ec2_key
  subnet_id              = aws_subnet.Foursure-subnet-pub.id
  vpc_security_group_ids = [aws_security_group.Foursure-Security-Group.id]

  # This will make the instance publicly available via its public IP
  associate_public_ip_address = true

  tags = {
    Name = "Foursure-EC2-Instance"
  }
}

# Create an RDS PostgreSQL instance
resource "aws_db_instance" "Foursure_rds_instance" {
  engine            = "postgres"
  instance_class    = var.rds_instance_type
  allocated_storage = var.rds_allocated_storage
  identifier        = "foursure-rds-instance"
  skip_final_snapshot = true

  # Username and password for the master user
  username = var.rds_username
  password  = base64encode(var.rds_password)

  # The RDS instance will be in the same subnet as the EC2 instance
  #subnet_group_name = aws_subnet.Foursure-subnet-pub.id

  tags = {
    Name = "FoursureRDSInstance"
  }
}
