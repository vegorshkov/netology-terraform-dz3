resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
      gr_web   = yandex_compute_instance.web
      gr_db    = yandex_compute_instance.db
      gr_storage = [yandex_compute_instance.storage]
    }
  )
  filename = "${abspath(path.module)}/inventory.ini"
}
