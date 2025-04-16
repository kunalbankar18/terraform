output "flask_instance_ip" {
  value = aws_instance.flask.public_ip
}

output "express_instance_ip" {
  value = aws_instance.express.public_ip
}