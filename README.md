# Terraform module for running [Atlantis](https://www.runatlantis.io) on Azure app service


<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.72, < 3.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.83.0 |
| <a name="provider_github"></a> [github](#provider\_github) | 4.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_webhook"></a> [webhook](#module\_webhook) | ./modules/webhook | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) | resource |
| [azurerm_app_service_plan.plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan) | resource |
| [azurerm_application_insights.app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_container_group.aci](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_monitor_autoscale_setting.scale](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_role_assignment.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_storage_account_sas.sas](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account_sas) | data source |
| [github_ip_ranges.git](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/ip_ranges) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alert_emails"></a> [alert\_emails](#input\_alert\_emails) | # auto-scale | `list(string)` | `[]` | no |
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | list of ips | `list(string)` | `[]` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | n/a | `number` | `1` | no |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | n/a | `number` | `2` | no |
| <a name="input_dns_name_label"></a> [dns\_name\_label](#input\_dns\_name\_label) | n/a | `string` | `"atlantis"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to launch the container instances. | `bool` | `true` | no |
| <a name="input_github_repo_allowlist"></a> [github\_repo\_allowlist](#input\_github\_repo\_allowlist) | n/a | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | The git hub access token with repo scope | `string` | n/a | yes |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | the git hub user | `string` | n/a | yes |
| <a name="input_github_webhook_secret"></a> [github\_webhook\_secret](#input\_github\_webhook\_secret) | n/a | `string` | n/a | yes |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | Whether the container instance will have a public ip and dns | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | the azure region | `string` | `"eastus2"` | no |
| <a name="input_name"></a> [name](#input\_name) | names to be applied to resources | `string` | n/a | yes |
| <a name="input_network_profile_id"></a> [network\_profile\_id](#input\_network\_profile\_id) | The network profile id. Required if is\_public is false | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `null` | no |
| <a name="input_tfe_token"></a> [tfe\_token](#input\_tfe\_token) | the tfe / cloud user or team token | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_default_hostname"></a> [app\_default\_hostname](#output\_app\_default\_hostname) | n/a |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | n/a |
| <a name="output_app_outbound_ip_list"></a> [app\_outbound\_ip\_list](#output\_app\_outbound\_ip\_list) | n/a |
| <a name="output_app_principal_id"></a> [app\_principal\_id](#output\_app\_principal\_id) | n/a |
| <a name="output_ip_white_list"></a> [ip\_white\_list](#output\_ip\_white\_list) | n/a |

<!--- END_TF_DOCS --->


