output "sagemaker_flow_definitions_id" {
  description = "Map of id values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_flow_definitions_arn" {
  description = "Map of arn values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_flow_definitions_flow_definition_name" {
  description = "Map of flow_definition_name values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.flow_definition_name if v.flow_definition_name != null && length(v.flow_definition_name) > 0 }
}
output "sagemaker_flow_definitions_human_loop_activation_config" {
  description = "Map of human_loop_activation_config values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => one(v.human_loop_activation_config) if v.human_loop_activation_config != null && length(v.human_loop_activation_config) > 0 }
}
output "sagemaker_flow_definitions_human_loop_config" {
  description = "Map of human_loop_config values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => one(v.human_loop_config) if v.human_loop_config != null && length(v.human_loop_config) > 0 }
}
output "sagemaker_flow_definitions_human_loop_request_source" {
  description = "Map of human_loop_request_source values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => one(v.human_loop_request_source) if v.human_loop_request_source != null && length(v.human_loop_request_source) > 0 }
}
output "sagemaker_flow_definitions_output_config" {
  description = "Map of output_config values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => one(v.output_config) if v.output_config != null && length(v.output_config) > 0 }
}
output "sagemaker_flow_definitions_region" {
  description = "Map of region values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_flow_definitions_role_arn" {
  description = "Map of role_arn values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.role_arn if v.role_arn != null && length(v.role_arn) > 0 }
}
output "sagemaker_flow_definitions_tags" {
  description = "Map of tags values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_flow_definitions_tags_all" {
  description = "Map of tags_all values across all sagemaker_flow_definitions, keyed the same as var.sagemaker_flow_definitions"
  value       = { for k, v in aws_sagemaker_flow_definition.sagemaker_flow_definitions : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

