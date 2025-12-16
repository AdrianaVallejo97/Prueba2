data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "lt" {
  name_prefix   = "lab-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir /app
cd /app

cat <<EOT > docker-compose.yml
version: "3.8"
services:
  backend:
    image: atvallejo/backend:latest
    ports:
      - "3000:3000"

  frontend:
    image: atvallejo/frontend:latest
    ports:
      - "80:80"
    depends_on:
      - backend
EOT

/usr/local/bin/docker-compose up -d
EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 4
  min_size         = 4
  max_size         = 4

  vpc_zone_identifier = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]
}
