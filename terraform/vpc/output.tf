
output "subnet-id0" {
  value = aws_subnet.public-subnet[0].id
}
output "subnet-id1" {
  value = aws_subnet.public-subnet[1].id
}
output "subnet-id2" {
  value = aws_subnet.private-subnet[0].id
}
output "subnet-id3" {
  value = aws_subnet.private-subnet[1].id
}

output "vpc-id" {
    value = aws_vpc.myvpc.id
  
}
output "dependent" {
    value = aws_vpc.myvpc
  
}

