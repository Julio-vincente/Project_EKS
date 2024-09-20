variable "name_waf_prod" {
    type = string
    default = "WAF_Prod"
}

variable "description_waf_prod" {
    type = string
    default = "AWS WAFv2 Web ACL with Core Rule Set"
}

variable "rule_name" {
    type = string
    default = "AWSManagedRulesCommonRuleSet"
}

variable "rule_name_cors" {
    type = string
    default = "aws-managed-rules-crs"
}