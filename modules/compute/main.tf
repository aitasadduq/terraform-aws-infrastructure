data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]
    filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
    }
}

resource "aws_iam_role" "web" {
    name               = "web"
    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [{
            "Action": "sts:AssumeRole",
            "Principal": { "Service": "ec2.amazonaws.com" },
            "Effect": "Allow"
        }]
    })
}

resource "aws_iam_instance_profile" "web" {
    name = "web"
    role = aws_iam_role.web.name
}

resource "aws_iam_role_policy_attachment" "web" {
    role       = aws_iam_role.web.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_instance" "web" {
    ami                         = data.aws_ami.amazon_linux.id
    instance_type               = var.instance_type
    subnet_id                   = var.subnet_id
    vpc_security_group_ids      = var.security_group_ids
    iam_instance_profile        = aws_iam_instance_profile.web.name
    user_data                   = file("${path.module}/userdata.sh")
    associate_public_ip_address = true
    key_name                    = var.key_name != "" ? var.key_name : null

    tags = {
        Name = "${var.environment}-web-server"
    }
}