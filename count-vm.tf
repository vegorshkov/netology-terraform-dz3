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
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
  
  depends_on = [yandex_compute_instance.db]
}