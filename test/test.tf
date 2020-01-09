data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-ami-hvm.*-ebs"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "bastion" {
  "source"                = "../"
  "bucket_name"           = "my_famous_bucket_name"
  "region"                = "eu-west-1"
  "vpc_id"                = "my_vpc_id"
  "is_lb_private"         = "true"
  "bastion_host_key_pair" = "my_key_pair"
  "hosted_zone_name"      = "my.hosted.zone.name."
  "bastion_record_name"   = "bastion.my.hosted.zone.name."
  "bastion_ami"           = data.aws_ami.amazon-linux-2.id

  "elb_subnets" = [
    "subnet-id1a",
    "subnet-id1b",
  ]

  "auto_scaling_group_subnets" = [
    "subnet-id1a",
    "subnet-id1b",
  ]

  tags = {
    "name"        = "my_bastion_name"
    "description" = "my_bastion_description"
    "toto"        = "tate"
  }

  create_dns_record = true
}
