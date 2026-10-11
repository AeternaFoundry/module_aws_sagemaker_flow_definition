resource "aws_sagemaker_flow_definition" "sagemaker_flow_definitions" {
  for_each = var.sagemaker_flow_definitions

  flow_definition_name = each.value.flow_definition_name
  role_arn             = each.value.role_arn
  region               = each.value.region
  tags                 = each.value.tags
  tags_all             = each.value.tags_all

  human_loop_config {
    human_task_ui_arn = each.value.human_loop_config.human_task_ui_arn
    dynamic "public_workforce_task_price" {
      for_each = each.value.human_loop_config.public_workforce_task_price != null ? [each.value.human_loop_config.public_workforce_task_price] : []
      content {
        dynamic "amount_in_usd" {
          for_each = public_workforce_task_price.value.amount_in_usd != null ? [public_workforce_task_price.value.amount_in_usd] : []
          content {
            cents                     = amount_in_usd.value.cents
            dollars                   = amount_in_usd.value.dollars
            tenth_fractions_of_a_cent = amount_in_usd.value.tenth_fractions_of_a_cent
          }
        }
      }
    }
    task_availability_lifetime_in_seconds = each.value.human_loop_config.task_availability_lifetime_in_seconds
    task_count                            = each.value.human_loop_config.task_count
    task_description                      = each.value.human_loop_config.task_description
    task_keywords                         = each.value.human_loop_config.task_keywords
    task_time_limit_in_seconds            = each.value.human_loop_config.task_time_limit_in_seconds
    task_title                            = each.value.human_loop_config.task_title
    workteam_arn                          = each.value.human_loop_config.workteam_arn
  }

  output_config {
    kms_key_id     = each.value.output_config.kms_key_id
    s3_output_path = each.value.output_config.s3_output_path
  }

  dynamic "human_loop_activation_config" {
    for_each = each.value.human_loop_activation_config != null ? [each.value.human_loop_activation_config] : []
    content {
      dynamic "human_loop_activation_conditions_config" {
        for_each = human_loop_activation_config.value.human_loop_activation_conditions_config != null ? [human_loop_activation_config.value.human_loop_activation_conditions_config] : []
        content {
          human_loop_activation_conditions = human_loop_activation_conditions_config.value.human_loop_activation_conditions
        }
      }
    }
  }

  dynamic "human_loop_request_source" {
    for_each = each.value.human_loop_request_source != null ? [each.value.human_loop_request_source] : []
    content {
      aws_managed_human_loop_request_source = human_loop_request_source.value.aws_managed_human_loop_request_source
    }
  }
}

