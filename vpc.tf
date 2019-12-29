#VPC
resource "aws_vpc" "main"{
	cidr_block = "10.0.0.0/16"
	instance_tenancy="default"
	enable_dns_support="true"
	enable_dns_hostnames="true"
	enable_classiclink="false"
	tags={
	Name="main"
	}
}

#Public Subnets

resource "aws_subnet" "main-public-1"{
	vpc_id = aws_vpc.main.id
	cidr_block="10.0.1.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-1a"

	tags = {
	Name ="main-public-1"
	}
}

resource "aws_subnet" "main-public-2"{
	vpc_id=aws_vpc.main.id
	cidr_block="10.0.2.0/24"
	map_public_ip_on_launch = "true"
	availability_zone = "us-east-1b"

	tags = {
		Name="main-public-2"

	}
}

#Private Subnets

resource "aws_subnet" "main-private-1"{
	
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.3.0/24"
	map_public_ip_on_launch = "false"
	availability_zone = "us-east-1a"

	tags = {
	Name= "main-private-1"
	}

}

resource "aws_subnet" "main-private-2"{
	
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.4.0/24"
	map_public_ip_on_launch = "false"
	availability_zone = "us-east-1b"

	tags = {
	Name= "main-private-2"
	}

}

# IGW
resource "aws_internet_gateway" "main-gw"{
	
	vpc_id=aws_vpc.main.id

}

# Route Tables
resource "aws_route_table" "public-rt"{
	
	vpc_id=aws_vpc.main.id
	route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.main-gw.id 
	}

	tags ={
	Name = "public-rt"
	}
}

#Subnet Association - public 
resource "aws_route_table_association" "main-public-1a"{
	subnet_id = aws_subnet.main-public-1.id
	route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "main-public-2b"{
	subnet_id = aws_subnet.main-public-2.id
	route_table_id = aws_route_table.public-rt.id
}
