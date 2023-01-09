# AWS EKS EBS-CSI driver terraform module

Made by <img src="logo.png" width="60" margin alt="Miso"> with ❤️

## Description

A terraform module to deploy the out-of-tree EBS-CSI on Amazon EKS cluster.

### Installing

You can install this module as follows:

```tf
locals {
  csi_values = {
    "replicaCount" : 1,
    "podLabels" : {
      "app" : "ebs-csi"
    }
  }
}

module "ebs_csi" {
  source = "git::https://github.com/getmiso/terraform-aws-eks-ebs-csi-driver.git"

  enabled = true

  cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn

  helm_release_name = "ebs-csi"
  namespace         = "ebs-csi"

  service_account_name = "${terraform.workspace}-ebs-csi"
  irsa_role_name_prefix = "${terraform.workspace}-ebs-csi-controller"

  values = yamlencode(local.csi_values)
}
```

### Usage
You can refer to [this](https://github.com/kubernetes-sigs/aws-ebs-csi-driver) repository to learn more about aws-ebs-csi-driver.