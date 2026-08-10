resource "aws_instance" "this" {
  ami                     = "ami-0224ce6f9504665ee"
  instance_type           = var.instance_type
}

resource "aws_instance" "ec2-import-test" {
  ami                     = "ami-0224ce6f9504665ee"
  instance_type           = var.instance_type
  tags = {
    Name = "terraform import"
  }
}