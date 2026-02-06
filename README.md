# netology-terraform-dz3
"Управляющие конструкции в коде Terraform"


Задание №1  "Прочитать проект и инициализировать".
В проекте настраиваются группы безопасности согласно security.tf  так же доступ и создание производится через IAM ключ который генерируется на определенное время.
"Чувствительные данные" закрыты от публикации через .gitignore
Решение по заданию представлено в ./task1 в принтскринах, в хронологическом порядке.

Задание №2  "Cоздание двух одинаковых ВМ"
Машины созданы, параметры заданы через переменные, использован  count=2 и count.index который возвращает значение 0, 1,...  так как 2 то 2 значения, функция file в local-переменной для считывания ключа. Обновлен ключ через "yc iam create-token"

Задание №3
Выполнено.
Ключевая информация отображена в https://github.com/vegorshkov/netology-terraform-dz3/blob/main/task3/README.md

Задание №4
Все ключевые момент фиксированы на принтскринах, так же составлено краткое описание в комментариях и  в README.md в папке task4
https://github.com/vegorshkov/netology-terraform-dz3/tree/main/task4 

Задание №5
Добавим файл output.tf  (и создадим  нем вывод информации), получим информацию о созданных машинах.

Ответ: https://github.com/vegorshkov/netology-terraform-dz3/blob/main/task5/terraform_output.png

Задача №6

https://github.com/vegorshkov/netology-terraform-dz3/tree/main/task6#readme

Проблемма была в передаче ключей на хосты, но они туда передались. И получилось удаленно подключиться.

Задача №7
https://github.com/vegorshkov/netology-terraform-dz3/blob/main/task7/%D0%9E%D1%82%D0%B2%D0%B5%D1%82.png

Поочередно проверил вывод через переменные, выполнил операцию исключения из массива 3 элемента,   а далее   использовал объединение.

Задача №8
https://github.com/vegorshkov/netology-terraform-dz3/blob/main/task8/README.md

Ошибки найдены описание по ссылке выше.

Задача №9 
Команды собраны здесь
https://github.com/vegorshkov/netology-terraform-dz3/blob/main/task9/commandos.txt
