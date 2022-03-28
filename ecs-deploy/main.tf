
resource "aws_ecs_cluster" "pmc-cluster" {
     name       =   var.ecs_cluster_name

  
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "service"
  container_definitions = "${file("F:/GIIT/terraform-project-capsule/projectC/modules/ecs-deploy/task-definitions/service.json")}"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  memory = 512
  cpu = 256
  execution_role_arn = "${aws_iam_role.ecsTaskExecutionRole.arn}"

/* 
  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  } */
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "ecsTaskExecution"
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
  role = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}
resource "aws_ecs_service" "ecs_service" {
    name = var.task_service_name
    cluster = aws_ecs_cluster.pmc-cluster.name
    task_definition = aws_ecs_task_definition.ecs_task.id
    desired_count = 2
 
    network_configuration {
      subnets = [ "${aws_default_subnet.default_subnet_a.id}","${aws_default_subnet.default_subnet_b.id}"]
      #assign_public_ip = true
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

