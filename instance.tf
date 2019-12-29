resource "aws_key_pair" "mykey"{
	key_name="mykey"
	public_key=file((var.PATH_TO_PUBLIC_KEY))
}

#Instance in Public Subnets will be created by asg

#Instance In 1st Private Subnet
resource "aws_instance" "private-1"{
	ami = lookup(var.AMIS, var.AWS_REGION)
	instance_type = "t2.micro"

#VPC Private Subnet 1
	subnet_id = aws_subnet.main-private-1.id

#VPC Security Group
	vpc_security_group_ids = [aws_security_group.private-sg.id]

#Public SSH Key
	key_name=aws_key_pair.mykey.key_name	

}

#Instance In 2nd Private Subnet
resource "aws_instance" "private-2"{
	ami = lookup(var.AMIS, var.AWS_REGION)
	instance_type = "t2.micro"

#VPC Private Subnet 2
	subnet_id = aws_subnet.main-private-2.id

#VPC Security Group
	vpc_security_group_ids = [aws_security_group.private-sg.id]

#Public SSH Key
	key_name=aws_key_pair.mykey.key_name	

}



