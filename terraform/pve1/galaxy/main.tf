module "galaxy" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.3"
  proxmox_node_name   = "pve1"
  disk_name           = "sda"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "galaxy"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["prod", "debian12"]
  description         = "Managed by Terraform."
  memory              = 8192
  cores               = 2
  sockets             = 1
  disk_size           = 128
}
