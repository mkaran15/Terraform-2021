output"web-ip-address" {
    value = "Copy ${module.ec2.instance-public-ip[0]} and paste in your browser"
  
}