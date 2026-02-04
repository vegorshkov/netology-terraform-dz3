Задание 2 выполнено

Создан файл count-vm.tf, отмечен аргумент мета-аргумент count loop.

Назначил для ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance ), для остальных не назначал.

# В блоке network_interface ВМ web
network_interface {
  subnet_id = yandex_vpc_subnet.develop.id
  security_group_ids = [yandex_vpc_security_group.example.id]
}


Создал файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" разных по cpu/ram/disk_volume , используя мета-аргумент for_each loop. Используйте для обеих ВМ одну общую переменную типа:
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}

Использовал функцию file в local-переменной для считывания ключа (~/.ssh/id_rsa.pub - сразу заменил на свой по полному пути )и его специально сгененрированный для ДЗ из задания 2.

Инициализировал проект, выполнил код.
Принтскрины приложены в ./task2
