resource "aws_ecs_service" "this" {
  name                               = "${var.app_name}-service"
  cluster                            = var.cluster_id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = 2
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  enable_ecs_managed_tags            = false
  enable_execute_command             = true
  scheduling_strategy                = "REPLICA"

  capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = var.capacity_provider_name
  }

  load_balancer {
    container_name   = var.app_name
    container_port   = 80
    target_group_arn = aws_lb_target_group.this.arn
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.task.id]
    subnets          = [var.private_subnet_a_id, var.private_subnet_c_id]
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }
}
