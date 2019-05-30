# ########## #
# LABEL DATA #
# ########## #

variable "namespace" {
  type        = "string"
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation"
}

variable "environment" {
  type        = "string"
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = "string"
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "name" {
  type        = "string"
  default     = ""
  description = "Name of the application"
}


variable "enabled" {
  type        = "string"
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "additional_tag_map" {
  type        = "map"
  default     = {}
  description = "Additional tags for appending to each tag map"
}

variable "context" {
  type        = "map"
  default     = {}
  description = "Default context to use for passing state between label invocations"
}


# ################## #
# TASK CONFIGURATION #
# ################## #

variable "task_role_arn" {
  type        = string
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  default     = null
}

variable "execution_role_arn" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  default     = null
}

variable "cpu" {
  type        = number
  description = "The number of cpu units used by the task."
}

variable "memory" {
  type        = number
  description = "The amount (in MiB) of memory used by the task."
}

variable "volumes" {
  type        = list(map)
  description = "A set of volume blocks that containers in your task may use."
  default     = null
}
