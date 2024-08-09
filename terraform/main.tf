data "selectel_mks_kube_versions_v1" "versions" {
  project_id = var.project_id
  region     = "ru-3"
}

resource "selectel_mks_cluster_v1" "ha_cluster" {
  name         = "cluster-webinar"
  project_id   = var.project_id
  region       = var.region
  kube_version = data.selectel_mks_kube_versions_v1.versions.latest_version
}



resource "selectel_mks_nodegroup_v1" "nodegroup_1" {
  cluster_id        = selectel_mks_cluster_v1.ha_cluster.id
  project_id        = var.project_id
  region            = var.region
  availability_zone = var.availability_zone
  nodes_count       = 1
  volume_type       = var.volume_type
  volume_gb         = var.volume_gb

  flavor_id = var.gpu_ng_flavor

  install_nvidia_device_plugin = false

  enable_autoscale    = true
  autoscale_min_nodes = 1
  autoscale_max_nodes = 3

}

data "selectel_mks_kubeconfig_v1" "kubeconfig" {
  cluster_id = selectel_mks_cluster_v1.ha_cluster.id
  project_id = var.project_id
  region     = var.region
}

resource "local_file" "kube_config_file" {
  content  = data.selectel_mks_kubeconfig_v1.kubeconfig.raw_config
  filename = "../kubernetes/kubeconfig"
}
