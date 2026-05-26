output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_id" { value = aws_subnet.public.id }

# Point these to the two DIFFERENT resources
output "private_subnet_id" { value = aws_subnet.private.id }
output "private_subnet_b_id" { value = aws_subnet.private_b.id }

output "private_subnets" {
  value = [aws_subnet.private.id, aws_subnet.private_b.id]
}