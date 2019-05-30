terraform {
  required_version = ">= 0.12"
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.6.0"

  enabled     = "${var.enabled}"

  name        = "${var.name}"
  namespace   = "${var.namespace}"
  environment = "${var.environment}"
  stage       = "${var.stage}"
  delimiter   = "${var.delimiter}"
  attributes  = ["${concat(var.attributes, list("ecs_task"))}"]
  tags        = "${var.tags}"

  context     = "${var.context}"
}

locals {
  container_definitions = join(",", var.container_definitions)
}

resource "aws_ecs_task_definition" "task" {
  family = module.label.id
  container_definitions = local.container_definitions

  task_role_arn = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  network_mode = "awsvpc"

  cpu = var.cpu
  memory = var.memory

  dynamic "volume" {
    for_each = var.volumes != null ? var.volumes : []

    content {
      name = volume.name
      host_path = volume.host_path

      dynamic "docker_volume_configuration" {
        for_each = volume.docker != null ? volume.docker : []

        content {
          scope = docker_volume_configuration.scope
          autoprovision = docker_volume_configuration.autoprovision
          driver = docker_volume_configuration.driver
          driver_opts = docker_volume_configuration.driver_opts
          labels = docker_volume_configuration.labels
        }
      }
    }
  }

  requires_compatibilities = "FARGATE"

  tags = module.label.tags
}

