output "public_ip_address" {
  value = aws_instance.webserver1.public_ip

}

output "dns_name" {
  value = aws_lb.my-application-lb.dns_name
}

output "vpc_cidr_blk" {
  value = aws_vpc.main.cidr_block
}

output "public_cidr_blk" {
  value = aws_subnet.aws_public2.cidr_block
}