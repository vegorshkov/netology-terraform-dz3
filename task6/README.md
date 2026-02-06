Здадние №6

Создал группы виртуалок, далее добавил для подключения к ним бастион хост, затем добился того что ключи передадуться к гостевым машинам за бастионом. 

При создании бастиона, почему-то не передался ключь. Из-за этого джамп хост не смог проксировать ssh сессии до других виртуалок.
Решил пересоздать хост.

Команды:
terraform taint yandex_compute_instance.bastion
terraform apply -auto-approve

После пересоздания смотрим новый IP
terraform state show yandex_compute_instance.bastion

Далее запустил команды terraform apply -var="ansible_provision=true" -auto-approve

test.yaml  playbook для тестирования

ansible-playbook.tf  объединенный с ansible.tf  provisioner для ансибла


