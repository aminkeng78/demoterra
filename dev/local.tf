
locals {
  region = "us-east-1"
  mandatory_tag = {
    Project           = "rancherdemo"
    Builder           = "conilius"
    Owner             = "CONILIUS"
    Application_Owner = var.application_owner
    Group             = "conilius"
    Component_name    = var.component_name
  }
  vpc_id     = aws_vpc.rancherdemo_vpc[0].id
  creat_vpc  = var.custom_vpc
  azs        = data.aws_availability_zones.available.names
  subnet_ids = [aws_subnet.db_subnet[0].id, aws_subnet.db_subnet[1].id]
  aws_key_pair = data.aws_key_pair.rancher_key.key_name
}