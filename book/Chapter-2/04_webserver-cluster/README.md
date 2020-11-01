# 04 Развёртывание кластера серверов

## 2.04.1 Развёртывание кластера вэб-серверов

> p.86-90

- [x] 7.1 var `"instance_security_group_name"`
- [x] 7.2 `AS` - #7 Конфигурация запуска
  - `launch_conf`
  - `resource aws_autoscaling_group`
  - > :warning: **Error:** Error creating AutoScaling Group: ValidationError: At least one Availability Zone or VPC Subnet is required.
  - `subnet_ids`

```H
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
```

- `vpc_zone_identifier  = data.aws_subnet_ids.default.ids`

---

## 2.04.2 Подключение балансировщика нагрузки

- [x]1 Creating ALB
  - Проверять в `консоли AWS` в разделе `LOAD BALANCING > Load Balancers`
  - Ссылка на раздел: [https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#LoadBalancers:](https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#LoadBalancers:)
- [x] 2 `Add:` :new: `aws_lb_listener - default 404 page`
- [ ]3
- [ ]4
- [ ]5
- [ ]6
- [ ]7
- [ ]8
