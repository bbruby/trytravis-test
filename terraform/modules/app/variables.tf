variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  default     = "~/.ssh/appuser"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "machine_type" {
  description = "Machine type for instance"
  default     = "g1-small"
}
variable "db_ip" {
  description = "MongoDB IP"
}
variable "env" {
  description = "Environment"
}
variable "env_network" {
  description = "Environment network"
  default = "default"
}
variable "env_label" {
  description = "Instance environment label"
  default = "stage"
}
