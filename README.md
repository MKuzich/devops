# lesson-5 — Terraform (S3 backend, VPC, ECR)

## Опис

Проєкт створює:

- S3 бакет + DynamoDB таблицю для зберігання та блокування Terraform state
- VPC з 3 публічними та 3 приватними підмережами, IGW та NAT Gateway
- ECR репозиторій для Docker-образів

## Швидкий старт

1. Встановіть AWS CLI та налаштуйте `aws configure` (або export AWS credentials)
2. **Створіть S3 бакет перед `terraform init`** (деталі нижче)

### Варіант A — створити S3 бакет та DynamoDB вручну (через AWS CLI)

Створіть S3 бакет `aws s3 mb s3://terraform-state-bucket-mkuzich-1 --region eu-central-1` перед `terraform init`.

### Варіант B — bootstrap з локального бекенду

1. Тимчасово видаліть або закоментуйте `backend.tf` і запустіть `terraform init` для створення ресурсів (s3 + dynamodb)
2. Після створення бакету/таблиці — додайте `backend.tf` назад та перенастройте бекенд за допомогою `terraform init -reconfigure`

## Команди

`terraform init` - ініціалізація Terraform з бекендом S3
`terraform plan` - перегляд плану змін
`terraform apply` - застосування змін
`terraform destroy` - видалення створених ресурсів

## Важливо

- Імена бакетів S3 — глобально унікальні.
- Бекенд S3 повинен існувати до `terraform init`
- Переконайтесь, що у вашого IAM користувача/ролі є права для створення S3, DynamoDB, VPC, ECR, EC2 та EIP.
