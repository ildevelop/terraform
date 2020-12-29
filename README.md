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

### Listing the currently running environments is as easy as

```
terraform workspace list
```

### In order to create a workspace

```
terraform workspace new {NAME}
```

### Look list of workspace

```
terraform workspace list
```

### Select workspace

```
terraform workspace select {NAME}
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
terraform delete
```


### update to specific version of Terraform 

```
tfswitch 0.13.5
```

### terminal terraform

for testing yours function

```
terraform console
```
