resource "aws_appautoscaling_target" "this" {
  min_capacity       = 1
  max_capacity       = 2
  resource_id        = local.autoscaling_resource_id
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#politica de escalabilidade para memoria
resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "memory-autoscaling-${var.project}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = var.autoscaling.memory_autoscaling.target             #60%
    scale_in_cooldown  = var.autoscaling.memory_autoscaling.scale_in_cooldown  #300s para fazer up scale
    scale_out_cooldown = var.autoscaling.memory_autoscaling.scale_out_colldown #300s para fazer down scale

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

#politica de escalabilidae para a cpu
resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling-${var.project}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = var.autoscaling.cpu_autoscaling.target             #40%
    scale_in_cooldown  = var.autoscaling.cpu_autoscaling.scale_in_cooldown  #300s para fazer up scale
    scale_out_cooldown = var.autoscaling.cpu_autoscaling.scale_out_colldown #300s para fazer down scale

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

#politica de escalabilidade para requests
resource "aws_appautoscaling_policy" "ecs_policy_alb_request_count" {
  name               = "alb-request-count-autoscaling-${var.project}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.this.id
  scalable_dimension = aws_appautoscaling_target.this.scalable_dimension
  service_namespace  = aws_appautoscaling_target.this.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.autoscaling.alb_autoscaling.target #1000 requests

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_alb.this.arn_suffix}/${aws_alb_target_group.this.arn_suffix}"
    }
  }
}