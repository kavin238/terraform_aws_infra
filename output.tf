output "loadbalancer_dns" {
  value = aws_lb.myalb.dns_name
}
output "instance_ids" {
  value = {
    instance1 = aws_instance.webserver1.id
    instance2 = aws_instance.webserver2.id
  }
}
