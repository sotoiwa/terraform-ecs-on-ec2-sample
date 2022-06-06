resource "aws_autoscaling_group" "this" {
  name = "${var.app_name}-ecs-asg"

  vpc_zone_identifier = [var.private_subnet_a_id, var.private_subnet_c_id]

  min_size         = 0
  max_size         = 2
  desired_capacity = 0

  protect_from_scale_in = true

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.this.id
        version            = "$Latest"
      }

      override {
        instance_type = "m6i.large"
      }
    }
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = aws_ecs_cluster.this.name
    propagate_at_launch = true
  }
}
