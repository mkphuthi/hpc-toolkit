/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

data "google_compute_image" "compute_image" {
  family  = var.instance_image.family
  project = var.instance_image.project
}

module "slurm_cluster_controller" {
  source                        = "github.com/SchedMD/slurm-gcp//tf/modules/controller/?ref=v4.1.8"
  boot_disk_size                = var.boot_disk_size
  boot_disk_type                = var.boot_disk_type
  image                         = data.google_compute_image.compute_image.self_link
  instance_template             = var.controller_instance_template
  cluster_name                  = var.cluster_name != null ? var.cluster_name : "slurm-${var.deployment_name}"
  compute_node_scopes           = var.compute_node_scopes
  compute_node_service_account  = var.compute_node_service_account
  disable_compute_public_ips    = var.disable_compute_public_ips
  disable_controller_public_ips = var.disable_controller_public_ips
  labels                        = var.labels
  login_network_storage         = var.network_storage
  login_node_count              = var.login_node_count
  machine_type                  = var.controller_machine_type
  munge_key                     = var.munge_key
  jwt_key                       = var.jwt_key
  network_storage               = var.network_storage
  partitions                    = var.partition
  controller_startup_script     = var.controller_startup_script
  compute_startup_script        = var.compute_startup_script
  project                       = var.project_id
  region                        = var.region
  secondary_disk                = var.controller_secondary_disk
  secondary_disk_size           = var.controller_secondary_disk_size
  secondary_disk_type           = var.controller_secondary_disk_type
  shared_vpc_host_project       = var.shared_vpc_host_project
  scopes                        = var.controller_scopes
  service_account               = var.controller_service_account
  subnetwork_name               = var.subnetwork_name
  suspend_time                  = var.suspend_time
  zone                          = var.zone
  intel_select_solution         = var.intel_select_solution
  cloudsql                      = var.cloudsql
}
