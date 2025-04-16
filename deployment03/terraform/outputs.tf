output "alb_dns_name" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}

output "flask_service_name" {
  description = "Name of the ECS Flask service"
  value       = aws_ecs_service.flask.name
}

output "express_service_name" {
  description = "Name of the ECS Express service"
  value       = aws_ecs_service.express.name
}

output "ecs_cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}
