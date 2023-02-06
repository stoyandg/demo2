output "both_public_subnets_id" {
    value = aws_subnet.both_public_subnets.*.id
}

output "both_private_subnets_id" {
    value = aws_subnet.both_private_subnets.*.id
}

output "id_vpc" {
  value = aws_vpc.demo2vpc.id
}