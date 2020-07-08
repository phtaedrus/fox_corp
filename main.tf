
  provider "aws" {
    profile    = "default"
    region     = var.region
  }

  #Instantiate EC2 Instance
  resource "aws_instance" "fox-ec2" {
    ami = var.ec2_ami_code
    instance_type = "t2.micro"

    provisioner "local-exec" {
      command = "echo public ip address: ${aws_instance.fox-ec2.public_ip} >> ./logs/ip_address.txt"
    }
  }

  #Instantiate S3 Bucket (Random 4 char string due to bucket tear down propagation time.)
  resource "aws_s3_bucket" "fox_s3" {
    bucket = "s3-foxcorp-test-${random_string.random.result}.com"

    provisioner "local-exec" {
      command = "echo bucket_name_log: ${aws_s3_bucket.fox_s3.bucket} >> ./logs/bucket_names.txt"
    }
  }

  #Output mostly for funsies because the docs folder contains relevant info
  output "fox_bucket_ip" {
    value = aws_s3_bucket.fox_s3.bucket
    depends_on = [
      aws_s3_bucket.fox_s3]
  }
  output "ec2_ip_address" {
    value = aws_instance.fox-ec2.public_ip
    depends_on = [
      aws_instance.fox-ec2]
  }



