# Развёртывание одного вэб-сервера

- AMI `Ubuntu / Debian family Os`
- :cool: use `busybox`
- :key: port `8080`
  
> Ingress = Вход

## About cidr

- Visit site [cidr.xyz](https://cidr.xyz)

## Security group

ASG = `AWS security Group`

```HCL
resource "aws_security_group" "instance"{
  name = "terraform-example-instance"

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

```

### Графы зависимостей

- Graphviz
- [GraphvizOnline](https://bitly.com/2mPbxmg) `[https://bitly.com/2mPbxmg`

#### конкретный пример

- [результат main_02.tf](https://bit.ly/3jClmkR)
- `resource "aws_instance"`
- `+ vpc_security_group_ids = [aws_security_group.instance.id]`

## Выбор AMI

:green_heart: ami-092391a11f8aa4b7b

```HCL
  #Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-092391a11f8aa4b7b (64-bit x86)
  ami = "ami-092391a11f8aa4b7b"
```

### не подходит

```  #Ubuntu Server 16.04 LTS (HVM) with SQL Server 2017 Standard -
  #ami = "ami-0b793c1e0d1dc4d28"
```

Error:

```Terminal
- ! Error: Error launching source instance: Uns
- upportedOperation: Microsoft SQL Server is not supported for the instance type 't2.micro'.
        status code: 400, request id: 0fe615c9-2843-49f4-9c51-bc768ee64b18
```
