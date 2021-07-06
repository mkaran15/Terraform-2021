resource "aws_db_instance" "wordpressdb" {
  depends_on = [aws_instance.wordpress]
  identifier = "wordpress-database"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "wordpress"
  username             = var.db_username
  password             = var.db_passwd
  publicly_accessible = true
  skip_final_snapshot  = true
  vpc_security_group_ids = ["sg-02105ebe2537fa73a"]
}

output "Enpoint_string"{
  value = aws_db_instance.wordpressdb.endpoint
}