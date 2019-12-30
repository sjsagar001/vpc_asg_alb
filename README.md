Terraform v0.12.18 <br>
Usage :<br>
  Generate SSH keys using "ssh-keygen -f mykey"<br>
  Terraform init<br>
  Terraform plan<br>
  Terraform apply<br>

Functionality:<br>
  Creates VPC<br>
  Creates 2 Public Subnet<br>
  Creates 2 Private Subnet<br>
  Creates IGW<br>
  Creates Public Route Table<br>
  Subnet Association and Route Table Configuration<br>
  Launches Instances in Private Subnets<br>
  Creates Target Group<br>
  Creates ASG with 2 Min Instances in Public Subnets<br>
  Attach ASG to Target Group<br>
  Creates ALB depended upon Target Group<br>
  ...
  
