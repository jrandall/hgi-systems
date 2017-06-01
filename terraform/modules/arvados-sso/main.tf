variable "flavour" {}
variable "domain" {}
variable "network_id" {}

variable "security_group_ids" {
  type    = "map"
  default = {}
}

variable "key_pair_ids" {
  type    = "map"
  default = {}
}

variable "image" {
  type    = "map"
  default = {}
}

variable "bastion" {
  type    = "map"
  default = {}
}

resource "openstack_compute_instance_v2" "arvados-sso" {
  provider        = "openstack"
  count           = 1
  name            = "arvados-sso"
  image_name      = "${var.image["name"]}"
  flavor_name     = "${var.flavour}"
  key_pair        = "${var.key_pair_ids["mercury"]}"
  security_groups = ["${var.security_group_ids["ssh"]}"]

  network {
    uuid           = "${var.network_id}"
    access_network = true
  }

  metadata = {
    ansible_groups = "arvados-ssos,arvados-cluster-ncucu"
    user           = "${var.image["user"]}"
    bastion_host   = "${var.bastion["host"]}"
    bastion_user   = "${var.bastion["user"]}"
  }

  # wait for host to be available via ssh
  provisioner "remote-exec" {
    inline = [
      "hostname",
    ]

    connection {
      type         = "ssh"
      user         = "${var.image["user"]}"
      agent        = "true"
      timeout      = "2m"
      bastion_host = "${var.bastion["host"]}"
      bastion_user = "${var.bastion["user"]}"
    }
  }
}

output "ip" {
  value = "${openstack_compute_instance_v2.arvados-sso.access_ip_v4}"
}
