resource "aws_ebs_snapshot" "snapshot" {
  depends_on=[null_resource.my_skills]
  volume_id = aws_ebs_volume.hard_disk.id

  tags = {
    Name = "snapshot"
  }
}