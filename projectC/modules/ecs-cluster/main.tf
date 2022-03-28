resource "aws_ecs_cluster" "this" {
    name =  var.ecs_cluster_name  
}

resource "aws_ecs_task_definition" "app" {
    family = "deployment"
    execution_role_arn = aws_iam_role.ecs_Role.arn
    network_mode = "awsvpc"
    requires_compatibilities = [ "FARGATE" ]
    cpu = 256
    memory = 512 
    container_definitions = jsonencode([
    {
      name      = "nodeapp"
      image     = "033099688585.dkr.ecr.us-east-1.amazonaws.com/test:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }])
}


resource "aws_ecs_service" "app_service" {
    name = var.service_name
    cluster = aws_ecs_cluster.this.id
    task_definition = aws_ecs_task_definition.app.arn
    desired_count = 1
    launch_type = "FARGATE"
    network_configuration {
      subnets = [ "${aws_default_subnet.default_subnet_a.id}","${aws_default_subnet.default_subnet_b.id}"]
      assign_public_ip = true
      security_groups = ["sg-0294cb5e943f278a7"]
    }
  
}


resource "aws_default_vpc" "default_vpc" {
}
resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "us-east-1a"
  
}

resource "aws_default_subnet" "default_subnet_b" {
   availability_zone = "us-east-1b"
  
}


resource "aws_iam_role" "ecs_Role" {
  name = "ecs_role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
  
}

data "aws_iam_policy_document" "assume_role_policy"{
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ "ecs-tasks.amazonaws.com" ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskEcecutionRole_policy" {
  role = "${aws_iam_role.ecs_Role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}