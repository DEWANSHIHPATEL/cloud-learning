output "web_server_public_ip" {
  description = "Public IP of our web server to test in browser"
  value       = module.compute.public_ip
}