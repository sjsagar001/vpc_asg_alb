#Launch Config with Apache Web Server
resource "aws_launch_configuration" "lconfig-apache"{
	name_prefix ="lconfig-apache"
	image_id =lookup(var.AMIS, var.AWS_REGION)
	instance_type ="t2.micro"
	key_name =aws_key_pair.mykey.key_name
	security_groups =[aws_security_group.allow-ssh.id]
	user_data="#!/bin/bash\nsudo yum update -y\nsudo yum install httpd -y\nsudo service httpd start\nsudo chown -R $USER:$USER /var/www\ncd /var/www/html\necho '<html><h1>Created By Sagar Jain</h1></html>' > index.html"
}

#ASG
resource "aws_autoscaling_group" "asg-example"{
	name ="asg-example"
	vpc_zone_identifier =[aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
	launch_configuration =aws_launch_configuration.lconfig-apache.name
	min_size =2
	max_size =3
	health_check_grace_period =300
	health_check_type ="ELB"
	force_delete =true
	target_group_arns=[aws_alb_target_group.tg-alb.arn]
	tag{
	key="Name"
	value="Ec2 Instance in Public Subnet with Apache Web Server"
	propagate_at_launch=true
	}
}
resource "aws_autoscaling_attachment" "alb_asg_att" {
  alb_target_group_arn=aws_alb_target_group.tg-alb.arn
  autoscaling_group_name=aws_autoscaling_group.asg-example.name
}

#Policy
resource "aws_autoscaling_policy" "cpu-policy"{
	name="cpu-policy"
	autoscaling_group_name=aws_autoscaling_group.asg-example.name
	adjustment_type ="ChangeInCapacity"
	scaling_adjustment ="1"
	cooldown ="300"
	policy_type ="SimpleScaling"
}

#CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cpu-alarm" {
  alarm_name          = "cpu-alarm"
  alarm_description   = "example-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.asg-example.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu-policy.arn]
}
