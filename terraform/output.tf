output "kubeconfig" {
  value     = data.selectel_mks_kubeconfig_v1.kubeconfig.raw_config
  sensitive = true
}