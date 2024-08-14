## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_selectel"></a> [selectel](#requirement\_selectel) | 5.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |
| <a name="provider_selectel"></a> [selectel](#provider\_selectel) | 5.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kube_config_file](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/resources/file) | resource |
| [selectel_mks_cluster_v1.ha_cluster](https://registry.terraform.io/providers/selectel/selectel/5.2.1/docs/resources/mks_cluster_v1) | resource |
| [selectel_mks_nodegroup_v1.nodegroup_1](https://registry.terraform.io/providers/selectel/selectel/5.2.1/docs/resources/mks_nodegroup_v1) | resource |
| [selectel_mks_kube_versions_v1.versions](https://registry.terraform.io/providers/selectel/selectel/5.2.1/docs/data-sources/mks_kube_versions_v1) | data source |
| [selectel_mks_kubeconfig_v1.kubeconfig](https://registry.terraform.io/providers/selectel/selectel/5.2.1/docs/data-sources/mks_kubeconfig_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `"ru-7a"` | no |
| <a name="input_gpu_ng_flavor"></a> [gpu\_ng\_flavor](#input\_gpu\_ng\_flavor) | n/a | `string` | `"3048"` | no |
| <a name="input_os_auth_url"></a> [os\_auth\_url](#input\_os\_auth\_url) | URL до openstack api | `string` | `"https://cloud.api.selcloud.ru/identity/v3"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ru-7"` | no |
| <a name="input_selectel_domain_name"></a> [selectel\_domain\_name](#input\_selectel\_domain\_name) | ID Selectel аккаунта | `string` | n/a | yes |
| <a name="input_selectel_user_name"></a> [selectel\_user\_name](#input\_selectel\_user\_name) | Имя сервисного пользователя, необходимо создать через панель my.selectel | `string` | n/a | yes |
| <a name="input_selectel_user_password"></a> [selectel\_user\_password](#input\_selectel\_user\_password) | Пароль от сервисного пользователя | `string` | n/a | yes |
| <a name="input_volume_gb"></a> [volume\_gb](#input\_volume\_gb) | n/a | `string` | `"100"` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | n/a | `string` | `"fast.ru-7a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
