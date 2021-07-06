resource "google_compute_instance" "wordpress" {
  name         = "wordpress"
  machine_type = var.machine_type
  zone         = "us-central1-a"
  tags = ["http-server"]
  can_ip_forward = var.ip_forward

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

   network_interface {
    network = "default"
    access_config {}
  }
  
}


resource "google_compute_firewall" "http-server" {
  name    = "allow-http-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
    allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.source_ranges
  target_tags = ["http-server"]
}
resource "null_resource" "host_wordpress" {
  connection{
    type = "ssh"
    user = "myash615"
    private_key = file("C:/Terraform/myash615.pem")
    host = google_compute_instance.wordpress.network_interface.0.access_config.0.nat_ip

}
  provisioner "remote-exec" {
    inline = [
		"sudo yum install httpd php php-mysqlnd php-json wget -y", 
		"sudo wget https://wordpress.org/latest.tar.gz",
		"tar -xzf latest.tar.gz",
		"sudo mv wordpress/* /var/www/html/",
		"sudo chown -R apache.apache /var/www/html",
		"sudo setenforce 0",
    "sudo systemctl stop firewalld",
		"sudo systemctl start httpd"
		
	    ]
  }
}


output "webserver_ip"{
    value = google_compute_instance.wordpress.network_interface.0.access_config.0.nat_ip
}