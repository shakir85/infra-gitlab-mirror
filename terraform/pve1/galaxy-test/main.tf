module "galaxy-test" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=main"
  proxmox_node_name   = "pve1"
  disk_name           = "sda"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "galaxy-test"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["galaxy-test"]
  description         = "Managed by Terraform."
  memory              = 1028
  cores               = 1
  sockets             = 1
  disk_size           = 20
}
