
  data "aws_iam_policy_document" "resource_full_access" {
    statement {
      sid       = "FullAccess"
      effect    = "Allow"
      resources = [aws_s3_bucket.fox_s3.bucket, aws_instance.fox-ec2.ami]

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


  resource "aws_iam_policy" "test-policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

  resource "aws_iam_policy_attachment" "attach-fox-policy" {
    name        = "attach-fox-policy"
    users        = [aws_iam_user.fox_user.name]
    policy_arn  = aws_iam_policy.test-policy.arn
  }