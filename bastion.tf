resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  hostname    = "bastion"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 5
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true  # У бастиона есть внешний IP
  }

#  передается файл ключа на бастион...  или затрял где-то...
  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  scheduling_policy {
    preemptible = true
  }
}

