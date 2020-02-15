## Terraform tutorial

### Environments AWS

add to `provider` access environments OR run in terminal

`export AWS_ACCESS_KEY_ID=YOUR_KEY`  
`export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY`  
`export AWS_DEFAULT_REGION=YOUR_REGION`

### run terraform

search from `.tf` files provider and upload all instances

```
terraform init
```

### search plan (check instances)

```
terraform plan
```

### create instance

```
terraform apply
```

### delete all instances

destroy all instances from `.tf` file

```
terraform destroy
```

### terminal terraform

for testing yours function

```
terraform console
```
