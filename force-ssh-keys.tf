resource "null_resource" "force_ssh_keys" {
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]

  for_each = merge(
    { for idx, vm in yandex_compute_instance.web : "web-${idx}" => vm },
    { for k, vm in yandex_compute_instance.db : k => vm },
    { "storage" = yandex_compute_instance.storage }
  )

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = each.value.network_interface[0].nat_ip_address
    private_key = file("/home/vgorshkov/.ssh/netology-ext-key")
    timeout     = "10m"
  }

  # Принудительно перезаписываем authorized_keys
  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ssh",
      "echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGsV4FbyZ3PqkzeSGNvDLFHBY7xv8t4oWavwhzwqErDe vgorshkov@gid-000455' > ~/.ssh/authorized_keys",
      "chmod 600 ~/.ssh/authorized_keys",
      "echo 'Key forced at $(date)' > /tmp/ssh-key-forced.log"
    ]
  }
}
