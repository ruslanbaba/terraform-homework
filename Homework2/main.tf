
#key
resource "aws_key_pair" "Bastion-key" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_s3_bucket" "kaizen-ruslan" {
  bucket = "kaizen-ruslan"
}
resource "aws_s3_bucket" "kaizen" {
  bucket_prefix = "kaizen"
}
# Create manually two more buckets(S3)
#terraform import aws_s3_
#terraform import aws_s3_

resource "aws_s3_bucket" "kaizen-ruslanb09" {
  bucket_prefix = "kaizen-ruslanb09"
}
resource "aws_s3_bucket" "kaizen-ruslanb03" {
  bucket_prefix = "kaizen-ruslanb03"
}

resource "aws_iam_user" "user" {
  for_each = set (["jenny", "rose", "lisa", "jisoo"]) 
  name = each.key 
}

resource "aws_iam_group" "team" {
  name = "blackpink"
}

resource "aws_iam_group_membership" "team" {
  name = "blackpink"

  users = [
 for i in aws_iam_user.user : i.name
  ]
  group = aws_iam_group.team.name
}
