# 정보
초기 환경 설정용 Terraform.

## 사용방법
1. `terraform init` 명령 수행
2. `terraform validate` 명령 수행 후, 정상이면 `terraform plan -out "init"` 명령 수행.
3. `terraform apply "init"` 명령 수행.

## 인프라 해체
1. S3 force-destroy 가 가능하도록. 코드를 수정하기.
2. `terraform destroy` 수행