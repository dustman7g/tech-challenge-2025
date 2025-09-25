#########################################################
# Auto Scaling Group Template
#########################################################

resource "aws_launch_template" "app_lt" {
  name_prefix = "app-lt-"
  image_id    = data.aws_ami.amazon_linux_2.id
  #instance_type = "t2.micro"
  instance_type          = "t3.micro" ########### t3.micro is on free
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = aws_key_pair.management.key_name
  user_data              = base64encode(file("${path.module}/userdata.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-server"
    }
  }
}

#########################################################
# Auto Scaling Group 
#########################################################

resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  desired_capacity          = var.asg_desired
  min_size                  = var.asg_min
  max_size                  = var.asg_max
  vpc_zone_identifier       = [for s in aws_subnet.app : s.id]
  health_check_type         = "EC2"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "app-asg"
    propagate_at_launch = true
  }
}