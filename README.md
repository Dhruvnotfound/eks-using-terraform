

# EKS Cluster Setup Using Terraform

This Terraform code sets up an Amazon Elastic Kubernetes Service (EKS) cluster and its associated resources on AWS. It includes the following main components:

1. **VPC**: A custom VPC with public and private subnets is created using the `terraform-aws-modules/vpc/aws` module.
2. **IAM Roles**: The necessary IAM roles for the EKS cluster and worker nodes are created with the required policy attachments.
3. **EKS Cluster**: An EKS cluster is created and configured with the specified VPC and IAM role.
4. **Node Group**: A node group (worker nodes) is created and attached to the EKS cluster, with the specified scaling configuration and IAM role.

## File Structure

- `provider.tf`: Defines the required AWS provider and configures the AWS region and credentials.
- `vpc.tf`: Creates a VPC with public and private subnets using the `terraform-aws-modules/vpc/aws` module.
- `iam.tf`: Creates the necessary IAM roles and policy attachments for the EKS cluster and worker nodes.
- `eks.tf`: Sets up the EKS cluster, node group, and updates the local Kubernetes configuration (kubeconfig) after provisioning.
- `variables.tf`: Defines the input variables for the Terraform configuration.

## Prerequisites

Before running this Terraform code, ensure you have the following:

- AWS account with appropriate permissions to create the required resources.
- AWS credentials configured locally (e.g., through `~/.aws/credentials` file or environment variables).
- Terraform installed on your local machine.

## Usage

1. Clone or download the Terraform code to your local machine.
2. Navigate to the directory containing the Terraform files.
3. Review and modify the `variables.tf` file as needed, adjusting the default values for variables like `availabilityZone`, `tag`, `Accregion`, and scaling configurations (`desired_size`, `max_size`, `min_size`).
4. Initialize the Terraform working directory:

   ```bash
   terraform init
   ```

5. Review the execution plan and make sure the resources to be created are as expected:

   ```bash
   terraform plan
   ```

6. Apply the Terraform configuration to create the resources:

   ```bash
   terraform apply
   ```

   Review the planned changes and type `yes` to confirm and apply the configuration.

7. After the apply completes successfully, Terraform will output the necessary information to access the EKS cluster, including the cluster name and the updated kubeconfig file location.

8. Configure your local `kubectl` to use the updated kubeconfig file, and you should be able to interact with the newly created EKS cluster.

## Cleanup

To remove all the resources created by this Terraform configuration, run the following command:

```bash
terraform destroy
```

Review the planned destruction and type `yes` to confirm and destroy the resources.

## Variables

The following input variables are defined in `variables.tf`:

- `availabilityZone`: A list of availability zones for the VPC subnets.
- `tag`: A tag name to apply to resources.
- `Accregion`: The AWS region where resources will be created.
- `desired_size`: The desired number of worker nodes in the node group.
- `max_size`: The maximum number of worker nodes in the node group.
- `min_size`: The minimum number of worker nodes in the node group.

## References

- EKS Service IAM Role: "https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html"
- EKS Node IAM Role: "https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html"
- VPC Module: "https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest"