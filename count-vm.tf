resource "yandex_compute_instance" "web" {
  count = 2  #  count loop  это задает сколько значений получит переменная count.index  
  
  name        = "web-${count.index + 1}"  # здесь описывается мета аргумент как "web-" + "номер+1"
  hostname    = "web${count.index + 1}"   # задаем имя хоста
  allow_stopping_for_update = true
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }  

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 5
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat = local.nat_enable_ext_ip
  }

  # Provisioner для принудительной установки ключа
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.network_interface[0].nat_ip_address
    private_key = file("/home/vgorshkov/.ssh/netology-ext-key")
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "echo '${local.ssh_public_key}' > ~/.ssh/authorized_keys",
      "chmod 600 ~/.ssh/authorized_keys"
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
    user-data = local.cloud_init_config
  }
  
  depends_on = [yandex_compute_instance.db]
}