# Selectel provider vars
variable "selectel_domain_name" {
  type        = string
  description = "ID Selectel аккаунта"
}

variable "selectel_user_name" {
  type        = string
  description = "Имя сервисного пользователя, необходимо создать через панель my.selectel"
}

variable "selectel_user_password" {
  type        = string
  description = "Пароль от сервисного пользователя"
}
variable "project_id" {
  type = string
}
variable "region" {
  default = "ru-7"
}
variable "availability_zone" {
  default = "ru-7a"
}
variable "volume_type" {
  default = "fast.ru-7a"
}
variable "volume_gb" {
  default = "100"
}
variable "gpu_ng_flavor" {
  default = "3041" # A30 3048, A100 3041, TeslaT4 3031
}
# Openstack provider vars
variable "os_auth_url" {
  type        = string
  default     = "https://cloud.api.selcloud.ru/identity/v3"
  description = "URL до openstack api"
}
