resource "aws_db_instance" "wordpressdb" {
  identifier = "wordpress-database"
  allocated_storage    = 20
  engine               = var.engine
  engine_version       = "5.7"
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_passwd
  publicly_accessible = true
  skip_final_snapshot  = true
  vpc_security_group_ids = ["sg-02105ebe2537fa73a"]
}

output "Enpoint_string"{
  value = aws_db_instance.wordpressdb.endpoint
}