variable "sagemaker_flow_definitions" {
  description = <<EOT
Map of sagemaker_flow_definitions, attributes below
Required:
    - flow_definition_name
    - role_arn
    - human_loop_config (block):
        - human_task_ui_arn (required)
        - public_workforce_task_price (optional, block):
            - amount_in_usd (optional, block):
                - cents (optional)
                - dollars (optional)
                - tenth_fractions_of_a_cent (optional)
        - task_availability_lifetime_in_seconds (optional)
        - task_count (required)
        - task_description (required)
        - task_keywords (optional)
        - task_time_limit_in_seconds (optional)
        - task_title (required)
        - workteam_arn (required)
    - output_config (block):
        - kms_key_id (optional)
        - s3_output_path (required)
Optional:
    - region
    - tags
    - tags_all
    - human_loop_activation_config (block):
        - human_loop_activation_conditions_config (optional, block):
            - human_loop_activation_conditions (required)
    - human_loop_request_source (block):
        - aws_managed_human_loop_request_source (required)
EOT

  type = map(object({
    flow_definition_name = string
    role_arn             = string
    region               = optional(string)
    tags                 = optional(map(string))
    tags_all             = optional(map(string))
    human_loop_config = object({
      human_task_ui_arn = string
      public_workforce_task_price = optional(object({
        amount_in_usd = optional(object({
          cents                     = optional(number)
          dollars                   = optional(number)
          tenth_fractions_of_a_cent = optional(number)
        }))
      }))
      task_availability_lifetime_in_seconds = optional(number)
      task_count                            = number
      task_description                      = string
      task_keywords                         = optional(set(string))
      task_time_limit_in_seconds            = optional(number)
      task_title                            = string
      workteam_arn                          = string
    })
    output_config = object({
      kms_key_id     = optional(string)
      s3_output_path = string
    })
    human_loop_activation_config = optional(object({
      human_loop_activation_conditions_config = optional(object({
        human_loop_activation_conditions = string
      }))
    }))
    human_loop_request_source = optional(object({
      aws_managed_human_loop_request_source = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        (length(v.flow_definition_name) >= 1 && length(v.flow_definition_name) <= 63) && (can(regex("^[0-9a-z](-*[0-9a-z])*$", v.flow_definition_name)))
      )
    ])
    error_message = "all of: must be between 1 and 63 characters; Valid characters are a-z, 0-9, and - (hyphen)."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_activation_config == null || (v.human_loop_activation_config.human_loop_activation_conditions_config == null || ((length(v.human_loop_activation_config.human_loop_activation_conditions_config.human_loop_activation_conditions) >= 1 && length(v.human_loop_activation_config.human_loop_activation_conditions_config.human_loop_activation_conditions) <= 10240) && (can(jsondecode(v.human_loop_activation_config.human_loop_activation_conditions_config.human_loop_activation_conditions)))))
      )
    ])
    error_message = "all of: must be between 1 and 10240 characters; must be valid JSON"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.public_workforce_task_price == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.cents == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.cents >= 0 && v.human_loop_config.public_workforce_task_price.amount_in_usd.cents <= 99)))
      )
    ])
    error_message = "must be between 0 and 99"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.public_workforce_task_price == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.dollars == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.dollars >= 0 && v.human_loop_config.public_workforce_task_price.amount_in_usd.dollars <= 2)))
      )
    ])
    error_message = "must be between 0 and 2"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.public_workforce_task_price == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.tenth_fractions_of_a_cent == null || (v.human_loop_config.public_workforce_task_price.amount_in_usd.tenth_fractions_of_a_cent >= 0 && v.human_loop_config.public_workforce_task_price.amount_in_usd.tenth_fractions_of_a_cent <= 9)))
      )
    ])
    error_message = "must be between 0 and 9"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.task_availability_lifetime_in_seconds == null || (v.human_loop_config.task_availability_lifetime_in_seconds >= 1 && v.human_loop_config.task_availability_lifetime_in_seconds <= 864000)
      )
    ])
    error_message = "must be between 1 and 864000"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.task_count >= 1 && v.human_loop_config.task_count <= 3
      )
    ])
    error_message = "must be between 1 and 3"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        length(v.human_loop_config.task_description) >= 1 && length(v.human_loop_config.task_description) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.task_keywords == null || (alltrue([for x in v.human_loop_config.task_keywords : (length(x) >= 1 && length(x) <= 30) && (can(regex("^[0-9A-Za-z]+( [0-9A-Za-z]+)*$", x)))]))
      )
    ])
    error_message = "all of: must be between 1 and 30 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        v.human_loop_config.task_time_limit_in_seconds == null || (v.human_loop_config.task_time_limit_in_seconds >= 30 && v.human_loop_config.task_time_limit_in_seconds <= 28800)
      )
    ])
    error_message = "must be between 30 and 28800"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        length(v.human_loop_config.task_title) >= 1 && length(v.human_loop_config.task_title) <= 128
      )
    ])
    error_message = "must be between 1 and 128 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_flow_definitions : (
        (can(regex("^(https|s3)://([^/])/?(.*)$", v.output_config.s3_output_path))) && (length(v.output_config.s3_output_path) >= 1 && length(v.output_config.s3_output_path) <= 512)
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

