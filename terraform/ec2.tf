resource "aws_instance" "instance" {
  count                     = local.LENGTH
  ami                       = "ami-074df373d6bafa625"
  instance_type             = "t3.micro"
  vpc_security_group_ids    = ["sg-03871c9a33425a291"]
  tags                      = {
    Name                    = element(var.COMPONENTS, count.index)
}

//resource "aws_ec2_tag" "name-tag" {
 // count                     = local.LENGTH
//  resource_id               = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
//  key                       = "Name"
//  value                     = element(var.COMPONENTS, count.index)
//}

resource "aws_route53_record" "records" {
  count                     = local.LENGTH
  name                      = element(var.COMPONENTS, count.index)
  type                      = "A"
  zone_id                   = "Z058717311P9VJRR1I7TD"
  ttl                       = 300
  records                   = [element(aws_instance.instance.*.private_ip, count.index)]
}
locals {
  LENGTH    = length(var.COMPONENTS)
}