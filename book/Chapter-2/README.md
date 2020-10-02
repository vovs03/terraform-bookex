# 2. Приступаем к работе с Terraform

- IAM
- `aws configure` // внести свои ключи от IAM
  - :key: `AWS_ACCESS_KEY_ID=(your access key id)`
  - :key: `AWS_SECRET_ACCESS_KEY=(your secret access key)`
- `~/.aws/credentials`

## Code

- `tf-code`
  - Выбрать `AMI` из списка
  - :heart: `tags {Name}`
- :construction:  - `.gitignore`
- :key: github

## :rocket: Рабочий процесс

### В консоли AWS

Новый интерфейс меня сбил с толку не мог найти выбор из списка `AMI`.

### :green_heart: Commands

- `terraform init`
- `terraform plan`
- `terraform applay`
- `terraform destroy`
  - :hammer: в консоли проверять завершение команды (а то в браузере смотрю, а процесс удаления не был запущен, я просто его не подтвердил :repeat: `+ yes`)
