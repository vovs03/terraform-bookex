# Развёртывание   конфигурируемого вэб-сервера

- AMI `Ubuntu / Debian family Os`
- :cool: use `busybox`
- :key: port `8080`
- `area` = 'FRANKFURT'
  
> Ingress = Вход

## Пример 3

### :a: Использование переменной `var.server_port` в разных фрагментах кода

`./variables.tf`

- строковая интреполяция в башизме: `"${...}"`

---

### :b: Bыходные переменные

`./outputs.tf`
