# Terraform bastion test

### Generate ssh keys
```
source ./init.sh
```

### Init terraform
```
terrafrom init
```

### Plan changes
```
terrafrom plan
```

### Apply changes
```
terrafrom apply
```

### Test bastion is up
```
ssh -i <key> ec2-user@<bastion-ip>
```

### Destroy
```
terrafrom destroy
```
