resource "aws_security_group" "allow-ssh"{
	vpc_id = aws_vpc.main.id
	name="allow-ssh"
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
		}
	tags ={
	Name = "allow-ssh"
	}
}

resource "aws_security_group" "private-sg"{
	vpc_id = aws_vpc.main.id
	name="private-sg"
	ingress {
		from_port = 0
		to_port = 65535
		protocol = "tcp"
		cidr_blocks = ["10.0.1.0/24","10.0.2.0/24"]
	}
	tags ={
	Name = "private-sg"
	}
}

resource "aws_security_group" "alb-sg"{
	vpc_id = aws_vpc.main.id
	name="alb-sg"
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		}
	
	tags ={
	Name = "alb-sg"
	}
}