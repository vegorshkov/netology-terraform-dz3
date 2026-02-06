output "bastion_metadata" {
  value = yandex_compute_instance.bastion.metadata
}

output "ssh_key_length" {
  value = length(local.ssh_public_key)
}
