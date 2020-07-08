
  #creates ec2 policy with * all permissions
  resource "aws_iam_policy" "fox_ec2_policy" {
    name = "fox_ec2_policy"
    description = "A test policy"

    policy = file("./policies/fox_ec2_policy.json")
  }

  #creates AWS IAM Role
  resource "aws_iam_role" "fox_ec2_role" {
    name = "fox_ec2_role"
    assume_role_policy = file("./policies/ec2_assume_policy.json")
  }

  #Instantiate AWS IAM
  resource "aws_iam_instance_profile" "fox_iam_profile" {
    name = "fox_iam_profile"
    role = aws_iam_role.fox_ec2_role.name
  }

  resource "aws_s3_bucket_policy" "fox_bucket_policy" {
    bucket = aws_s3_bucket.fox_s3.bucket

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal":  {
        "Service": "ec2.amazonaws.com"
      },
      "Action": ["s3:*" ],
      "Resource": [
        "${aws_s3_bucket.fox_s3.arn}",
        "${aws_s3_bucket.fox_s3.arn}/*"
      ]
    }
  ]
}
EOF

    depends_on = [aws_s3_bucket.fox_s3]
  }
