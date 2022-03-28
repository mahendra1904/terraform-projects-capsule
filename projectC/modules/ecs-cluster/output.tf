
# it will give the cluster name
output "cluster_name" {
    value = aws_ecs_cluster.this.name
  
}

# it will give the service name
output "service_name" {
    value = aws_ecs_service.app_service.name
  
}