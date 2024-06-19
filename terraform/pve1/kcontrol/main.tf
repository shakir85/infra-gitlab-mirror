module "kcontrol" {
  source              = "git::https://github.com/shakir85/terraform_modules.git//proxmox/vm?ref=v0.0.4"
  proxmox_node_name   = "pve1"
  disk_name           = "sdc"
  ssh_public_key_path = var.id_rsa_pub
  username            = "shakir"
  hostname            = "kcontrol"
  timezone            = "America/Los_Angeles"
  cloud_image_info    = ["sdc", "debian-12-generic-amd64.qcow2.img"]
  tags                = ["test", "k8s", "debian12"]
  description         = "Managed by Terraform. K8s control plane."
  memory              = 2048
  cores               = 2
  sockets             = 1
  disk_size           = 90
}
