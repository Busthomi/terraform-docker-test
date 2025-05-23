resource "aws_cloudwatch_metric_alarm" "durian_status_check_failed" {
  alarm_name          = "durian-status-check-failed"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Status check failure alarm"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.durian_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "durian_network_in" {
  alarm_name          = "durian-network-in-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Sum"
  threshold           = 50000000
  alarm_description   = "Network In usage high"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.durian_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "durian_network_out" {
  alarm_name          = "durian-network-out-usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Sum"
  threshold           = 50000000
  alarm_description   = "Network Out usage high"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.durian_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "durian_cpu_alarm_high" {
  alarm_name          = "durian-cpu-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = 45
  alarm_description   = "This alarm triggers when CPU >= 45%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.durian_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.durian_scale_up.arn]
}


#Cloudwatch Metric merupakan fitur logging yang memberikan informasi resources yang digunakan dalam Platform AWS.
#Serta apat menjadi acuan untuk memberikan notifikasi atau mentrigger proses lain.
#Seperti mentrigger Auto Scaling Group untuk menambahkan EC2.