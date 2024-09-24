resource "aws_security_group" "devbox" {
    name = "${var.system_id}-devbox-sg"
    vpc_id = var.vpc_id
    # tags = local.tags
}

resource "aws_security_group_rule" "devbox_ingress_ssh" {
    security_group_id = aws_security_group.devbox.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  // Allow SSH access from any IP address
}

resource "aws_security_group_rule" "devbox_ingress_proxy" {
    security_group_id = aws_security_group.devbox.id
    type = "ingress"
    from_port = 8888
    to_port = 8888
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "devbox_egress_all" {
    security_group_id = aws_security_group.devbox.id
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  // Allow outbound traffic to any IPv4 address
}

resource "aws_iam_instance_profile" "devbox" {
    name = "${var.system_id}-devbox-profile"
    role = aws_iam_role.devbox.name
}

resource "aws_iam_role" "devbox" {
    name = "${var.system_id}-devbox-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy" "devbox" {
    name = "${var.system_id}-devbox-policy"
    role = aws_iam_role.devbox.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "s3:*"
                ]
                Resource = "*"
            }
        ]
    })
}   

resource "aws_instance" "devbox" {
    ami = var.ubuntu_20_04_ami
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.devbox.id]
    subnet_id = var.public_subnet_id
    iam_instance_profile = aws_iam_instance_profile.devbox.name
    key_name = "${var.system_id}-${var.uuid_suffix}"
    associate_public_ip_address = true
    user_data = file("userdata.sh")
    tags = {
        Name = "${var.system_id}-${var.uuid_suffix}"
    }
}