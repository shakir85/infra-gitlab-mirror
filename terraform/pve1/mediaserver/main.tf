module "mediaserver" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.3"
  proxmox_node_name   = "pve1"
  disk_name           = "sdb"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "mediaserver"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["prod", "debian12"]
  description         = "Managed by Terraform."
  memory              = 16384
  cores               = 2
  sockets             = 2
  disk_size           = 256
}
