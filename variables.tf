variable "AmiName" {
	default = "Ixia_BreakingPoint_Virtual_Controller_11.20.20.18-prod-etszhwtguwj7m"
	description = "AMI name used for deploying instances"
	type = string
}

variable "AmiOwner" {
	default = "aws-marketplace"
	description = "Owner of AMI used for deploying instances"
	type = string
}

variable "Eth0SecurityGroupId" {
	description = "Id of the security group associated with first network interface"
	type = string
}

variable "Eth0SubnetId" {
	description = "Id of the subnet associated with the first network interface"
	type = string
}

variable "InstanceId" {
	default = "app"
	description = "Id of the instance of this module that ensures uniqueness"
	type = string
}

variable "InstanceName" {
	default = null
	description = "Custom instance name used to override the default automatically generated name"
	type = string
}

variable "InstanceType" {
	default = "c5.xlarge"
	description = "Instance type of VM"
	type = string
	validation {
		condition = contains([	"c6i.xlarge", "c6i.2xlarge",
								"c6a.xlarge", "c6a.2xlarge",
								"c6in.xlarge", "c6in.2xlarge",
								"c5.xlarge", "c5.2xlarge",
								"c5a.xlarge", "c5a.2xlarge",
								"c5n.xlarge", "c5n.2xlarge"
							], var.InstanceType)
		error_message = <<EOF
InstanceType must be one of the following types:
	t3a.xlarge, t3a.2xlarge,
	m6i.xlarge, m6i.2xlarge,
	m6a.xlarge, m6a.2xlarge,
	m6in.xlarge, m6in.2xlarge,
	m5.xlarge, m5.2xlarge,
	m5a.xlarge, m5a.2xlarge,
	m5n.xlarge, m5n.2xlarge,
	c6i.xlarge, c6i.2xlarge,
	c6a.xlarge, c6a.2xlarge,
	c6in.xlarge, c6in.2xlarge,
	c5.xlarge, c5.2xlarge,
	c5a.xlarge, c5a.2xlarge,
	c5n.xlarge, c5n.2xlarge
		EOF
	}
}

variable "SleepDelay" {
	default = "7m"
	description = "Time duration to delay to allow application to perform internal initialization required before use"
	type = string
}

variable "Tag" {
	default = "bps"
	description = "App ID tag of application using the deployment"
	type = string
}

variable "UserEmailTag" {
	default = "terraform@example.com"
	description = "Email address tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserEmailTag) >= 14
		error_message = "UserEmailTag minimum length must be >= 14."
	}
}

variable "UserLoginTag" {
	default = "terraform"
	description = "Login ID tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserLoginTag) >= 4
		error_message = "UserLoginTag minimum length must be >= 4."
	}
}

variable "UserProjectTag" {
	default = "module"
	description = "Project tag of user creating the deployment"
	type = string
}

variable "Version" {
	default = "11-20"
	description = "Versioning of the application using the deployment"
	type = string
}

variable "init_cli" {
	default = <<-EOF
#!/bin/bash -xe
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl status amazon-ssm-agent
BLADE_IPS=(10.0.10.11)
    EOF
	type = string
}