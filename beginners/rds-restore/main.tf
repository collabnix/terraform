# main.tf

# Configure the AWS provider
provider "aws" {
  region = "us-west-2" # Update with your desired region
}

# Define the RDS instance
resource "aws_db_instance" "example" {
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  identifier           = "my-rds-instance"
  username             = "admin"
  password             = "password"
  publicly_accessible = false

  # Other RDS configuration settings...

  # Enable automatic backups and set the retention period
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:05:00-sun:06:00"
}
