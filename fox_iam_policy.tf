
  data "aws_iam_policy_document" "resource_full_access" {
    statement {
      sid       = "FullAccess"
      effect    = "Allow"
      resources = ["arn:aws:s3:::${aws_s3_bucket.fox_s3.bucket}/path/*"]

      actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload"
      ]
    }
  }

  resource "aws_iam_user" "fox_user" {
    name = "fox_user"
  }

  resource "aws_iam_policy" "fox_ec2_policy" {
  name        = "fox_ec2_policy"
  description = "A test policy"
  role        = "${aws_iam_role.ec2_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

  resource "aws_iam_role" "ec2_role" {
    name = "ec2_role"
    
  }

  resource "aws_iam_policy_attachment" "attach-fox-policy" {
    name        = "attach-fox-policy"
    users        = [aws_iam_user.fox_user.name]
    policy_arn  = aws_iam_policy.test-policy.arn
  }