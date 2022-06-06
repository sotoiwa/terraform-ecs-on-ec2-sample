
resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 1
    capacity_provider = aws_ecs_capacity_provider.this.name
  }
}

resource "aws_ecs_capacity_provider" "this" {
  name = "my-${var.app_name}-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 10
      status                    = "ENABLED"
      target_capacity           = 80
    }
  }
}
