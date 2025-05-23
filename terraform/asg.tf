resource "aws_launch_template" "durian_lt" {
  name_prefix   = "durian-ec2-"
  image_id      = "ami-xxxx" #Kita harus sesuaikan dengan ID base image yang ingin kita gunakan. 
  instance_type = "t2.medium"

  monitoring {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "durian_asg" {
  desired_capacity     = 2
  max_size             = 5
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.durian_private_subnet.id]

  launch_template {
    id      = aws_launch_template.durian_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "durian-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "durian_scale_up" {
  name                   = "durian-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.durian_asg.name
}

#Launch Template merupakan fitur untuk membuat template EC2 agar bisa digunakan oleh Auto Scaling Group.
#Auto Scaling Group merupakan fitur untuk menambahkan atau mengurangi jumlah server yang ingin digunakan dan menggunakan Launch Template sebagai panduan EC2 yang ingin di tambahkan.
#Auto Scaling Group bisa menggunakan parameters untuk menambahkan dan mengurangi server.