resource "aws_volume_attachment" "ebs_attach" {
  depends_on = [aws_instance.task2_instance, aws_ebs_volume.task2_ebs_volume]
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.task2_ebs_volume.id
  instance_id = aws_instance.task2_instance.id
}