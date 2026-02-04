locals {
  ssh_public_key = file("/home/vgorshkov/.ssh/netology-ext-key.pub")  #  Используем функцию file в local-переменной для считывания ключа 
}
