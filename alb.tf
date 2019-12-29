#Target Group 
resource "aws_alb_target_group" "tg-alb"{
	name="tg-alb"
	port=80
	protocol="HTTP"
	vpc_id=aws_vpc.main.id

	health_check{
	path ="/index.html"
	healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10      
    port                = "80"  
	}
}

#Public Facing Application Load Balancer
resource "aws_alb" "alb-example"{
	name="alb-example"
	internal = false
	load_balancer_type = "application"
	subnets =[aws_subnet.main-public-1.id,aws_subnet.main-public-2.id]
	security_groups=[aws_security_group.alb-sg.id]
	tags={
	Name="alb-example"
	}

}
resource "aws_alb_listener" "alb_listener"{
	load_balancer_arn = aws_alb.alb-example.arn
	port ="80"
	default_action{
	target_group_arn=aws_alb_target_group.tg-alb.arn
	type="forward"
	}
}
