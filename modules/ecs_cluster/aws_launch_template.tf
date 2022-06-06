data "aws_ssm_parameter" "this" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "this" {
  name     = "${var.app_name}-ecs-lt"
  image_id = data.aws_ssm_parameter.this.value

  update_default_version = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 40
      volume_type = "gp3"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.this.name} >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;
EOF
  )
}
