module "logger" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.5"
  proxmox_node_name   = "pve1"
  disk_name           = "sda"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "logger"
  timezone            = "UTC"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["prod", "debian12"]
  description         = "Managed by Terraform. Logs management."
  memory              = 8192
  cores               = 2
  cpu_type            = "host"
  sockets             = 1
  disk_size           = 256
}
