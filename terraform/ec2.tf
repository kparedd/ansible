resource "aws_instance" "instances" {
  count = local.LENGTH
  ami = "ami-074df373d6bafa625"
  instance_type = "t3.micro"
  vpc_security_group_ids = ["sg-03871c9a33425a291"]
  tags = {
    Name = "${element(var.COMPONENTS, count.index)}-${var.ENV}"
  }
}



resource "aws_route53_record" "records" {
  count                     = local.LENGTH
  name                      = "${element(var.COMPONENTS, count.index)}-${var.ENV}"
  type                      = "A"
  zone_id                   = "Z058717311P9VJRR1I7TD"
  ttl                       = 300
  records                   = [element(aws_instance.instances.*.private_ip, count.index)]
}
locals {
  LENGTH    = length(var.COMPONENTS)
}


resource "local_file" "inventory-file" {
  //content     = "[FRONTEND]\n${aws_instance.instances.*.private_ip[9]}\n[PAYMENT]\n${aws_instance.instances.*.private_ip[8]}\n[SHIPPING]\n${aws_instance.instances.*.private_ip[7]}\n[USER]\n${aws_instance.instances.*.private_ip[6]}\n[CATALOGUE]\n${aws_instance.instances.*.private_ip[5]}\n[CART]\n${aws_instance.instances.*.private_ip[4]}\n[REDIS]\n${aws_instance.instances.*.private_ip[3]}\n[RABBITMQ]\n${aws_instance.instances.*.private_ip[2]}\n[MONGODB]\n${aws_instance.instances.*.private_ip[1]}\n[MYSQL]\n${aws_instance.instances.*.private_ip[0]}\n"
  content     = "[FRONTEND]\n${aws_instance.instances.*.private_ip[9]}\n[PAYMENT]\n${aws_instance.instances.*.private_ip[8]}\n[SHIPPING]\n${aws_instance.instances.*.private_ip[7]}\n[USER]\n${aws_instance.instances.*.private_ip[6]}\n[CATALOGUE]\n${aws_instance.instances.*.private_ip[5]}\n[CART]\n${aws_instance.instances.*.private_ip[4]}\n[REDIS]\n${aws_instance.instances.*.private_ip[3]}\n[RABBITMQ]\n${aws_instance.instances.*.private_ip[2]}\n[MONGODB]\n${aws_instance.instances.*.private_ip[1]}\n[MYSQL]\n${aws_instance.instances.*.private_ip[0]}\n"
  filename    = "/tmp/inv-roboshop"
}