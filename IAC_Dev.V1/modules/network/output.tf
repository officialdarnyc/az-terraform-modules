output "id" {
  value = module.virtual_network.id
}
output "subnet_id" {
  value = tomap({
    for key, subnet in module.subnet : key => subnet.id
  })
}
output "subnet_name" {
  value = tomap({
    for key, subnet in module.subnet : key => subnet.subnet_name
  })
}
