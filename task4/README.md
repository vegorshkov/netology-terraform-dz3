Задание №4

Через ansible.tf создал inventory-файл как по  примерам из лекции и source кодов.
Добавил задание имени хоста внутри виртуалки.
count-vm.tf: Исправлено, ни где не было  hostname = "web-${count.index + 1}" в ресурс yandex_compute_instance.web.
for_each-vm.tf: Исправлено, ни где не было  hostname = each.value.vm_name в ресурс yandex_compute_instance.db.
disk_vm.tf: Исправлено, ни где не было  hostname = "storage" в ресурс yandex_compute_instance.storage.

Так же получен файл inventory.ini в котором отображены все виртуальные машины.

Все результаты зафиксированнына print screens в разделе https://github.com/vegorshkov/netology-terraform-dz3/tree/main/task4 

