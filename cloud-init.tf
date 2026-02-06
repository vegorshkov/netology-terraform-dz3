locals {
  cloud_init_config = <<-YAML
    #cloud-config
    users:
      - name: ubuntu
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
          - ${local.ssh_public_key}
    package_update: true
    package_upgrade: true
    packages:
      - curl
      - wget
    runcmd:
      - systemctl enable --now ssh
      - echo "SSH key injected via cloud-init at $(date)" > /var/log/ssh-key-injected.log
  YAML
}
