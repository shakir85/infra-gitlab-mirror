module "testing" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.4"
  proxmox_node_name   = "pve1"
  disk_name           = "sdc"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "testing"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["test", "debian12"]
  description         = "Managed by Terraform. VM testing environment."
  memory              = 2048
  cores               = 1
  sockets             = 1
  disk_size           = 128
}
