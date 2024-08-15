module "devops" {
  // Required Variables
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.5"
  proxmox_node_name   = "pve1"
  disk_name           = "sdc"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "devops"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  disk_size           = 128
  memory              = 2048
  description         = "Managed by Terraform. DevOps work VM"
  tags                = ["devops", "debian12"]
  cores               = 2
  sockets             = 1
}

// Print any output block from the main module
output "module_outputs" {
  value = module.devops
}
