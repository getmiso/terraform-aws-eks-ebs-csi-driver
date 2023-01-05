variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster"
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
}

variable "helm_chart_name" {
  type        = string
  default     = "aws-ebs-csi-driver"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "2.14.1"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "aws-ebs-csi-driver"
  description = "Helm release name"
}
variable "helm_repo_url" {
  type        = string
  default     = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  description = "Helm repository"
}

variable "helm_create_namespace" {
  type        = bool
  default     = true
  description = "Create the namespace if it does not yet exist"
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "The K8s namespace in which the AWS EBS CSI driver service account has been created"
}

variable "settings" {
  type        = map(any)
  default     = {}
  description = "Additional helm sets which will be passed to the Helm chart values, see https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/charts/aws-ebs-csi-driver"
}

variable "values" {
  type        = string
  default     = ""
  description = "Additional yaml encoded values which will be passed to the Helm chart, see https://github.com/kubernetes-sigs/aws-ebs-csi-driver/tree/master/charts/aws-ebs-csi-driver"
}

variable "service_account_create" {
  type        = bool
  default     = true
  description = "Whether to create Service Account"
}

variable "service_account_name" {
  default     = "aws-ebs-csi-driver"
  description = "The k8s EBS CSI driver service account name"
}

variable "irsa_role_create" {
  type        = bool
  default     = true
  description = "Whether to create IRSA role and annotate service account"
}

variable "irsa_policy_enabled" {
  type        = bool
  default     = true
  description = "Whether to create opinionated policy to allow operations on specified zones in `policy_allowed_zone_ids`."
}

variable "irsa_additional_policies" {
  type        = map(string)
  default     = {}
  description = "Map of the additional policies to be attached to default role. Where key is arbitrary id and value is policy arn."
}

variable "irsa_role_name_prefix" {
  type        = string
  default     = "ebs-csi-controller"
  description = "The IRSA role name prefix for AWS EBS CSI controller"
}

variable "irsa_tags" {
  type        = map(string)
  default     = {}
  description = "IRSA resources tags"
}

variable "storage_classes_create" {
  type        = bool
  default     = true
  description = "Whether to create Storage Classes"
}

variable "storage_classes" {
  default = [
    {
      "name" : "ebs-csi-gp3"
      "annotations" : {
        "storageclass.kubernetes.io/is-default-class" : "true"
      }
      "allowVolumeExpansion" : true
      "volumeBindingMode" : "WaitForFirstConsumer"
      "reclaimPolicy" : "Delete"
      "parameters" : {
        "type" : "gp3"
        "encrypted" : "true"
      }
    }
  ]
  description = "List of the custom Storage Classes definitions"
}