resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      bastion_ip   = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
      bastion_name = yandex_compute_instance.bastion.name
      webservers   = yandex_compute_instance.web
      databases    = yandex_compute_instance.db
      storage      = [yandex_compute_instance.storage]
    }
  )
  filename = "${abspath(path.module)}/inventory.ini"
}
