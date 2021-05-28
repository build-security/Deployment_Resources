# aws-ec2-pdphost

Terraform module for creating AWS EC2 pdp instances running via docker.

## Example

```hcl
# main.tf
module "pdp_ec2" {
    source = "git@github.com:build-security/Deployment_Resources.git//terraform/pdp_ec2_module"
    pdp_api_key = "your pdp api key"
    pdp_api_secret = "your pdp secret"
    subnet_id = "your subnet id"
    ssh_key_name = "your aws ssh key name"
    region = "eu-west-1"
}

```

By default one t2 micro instance is  created with the one pdp docker available via port 80.
If you want to specify different variables, browse through the variables.tf file and adjust yours accordingly.

## Resources

These resources are always created:
- A EC2 instance
- A Security Group
    - A Security Group Rule for port 22/tcp
    - A Security Group Rule for each port / port range specified in variable `in_open_ports`
    - Note by default TCP ports 80,443,22 are open to all ranges but can be limited via variable in_cidr_blocks

## Outputs

The module by default will output your private and public pdp endpoints, so you can start working right away:

Example:

```bash
Outputs:

instance_id = [
  "i-0ff0014f14acd90c3",
]
private_pdp_endpoint = http://ip-10-10-0-44.eu-west-1.compute.internal/v1/data
public_pdp_endpoint = http://ec2-52-49-242-43.eu-west-1.compute.amazonaws.com/v1/data
```



