output "vm_info" {
  description = "Информация"
  value = concat(

    [
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],

    [
      for vm in yandex_compute_instance.db : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ]
  )
}
