variable "AWS_REGION"{
	default="us-east-1"
}

variable "AMIS"{
	type=map
	default={
	"us-east-1" ="ami-00eb20669e0990cb4" //N. Virginia
	"us-west-1"="ami-0bce08e823ed38bdd" //N. California
	"ap-south-1"="ami-02913db388613c3e1" //Mumbai
	"eu-central-1" ="ami-010fae13a16763bb4" //frankfurt
	}

}

variable "PATH_TO_PRIVATE_KEY"{
	default="mykey"
}

variable "PATH_TO_PUBLIC_KEY"{
	default="mykey.pub"
}

