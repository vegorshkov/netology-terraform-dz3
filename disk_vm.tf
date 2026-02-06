# Создаем 3 одинаковых диска с помощью count
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name     = "storage-disk-${count.index}"
  type     = "network-hdd"  # Можно изменить на "network-ssd" для SSD
  zone     = var.default_zone
  size     = 1  # ГБайт
  block_size = 4096
}

# Создаем виртуальную машину "storage"
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"  #   добавил имя хоста
  allow_stopping_for_update = true
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2 # количество ядер
    memory = 2 # память виртуалки allowed memory size: 2GB, 4GB, 6GB, 8GB, 10GB, 12GB, 14GB, 16GB.
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

  # Динамическое подключение созданных дисков
  dynamic "secondary_disk" {
    for_each = {
      for idx, disk in yandex_compute_disk.storage_disks : idx => disk.id
    }
    content {
      disk_id = secondary_disk.value
    }
  }

  # Создаем указание зависимости для создания дисков процесса создания VM
  depends_on = [yandex_compute_disk.storage_disks]
}
