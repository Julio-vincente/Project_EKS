resource "aws_wafv2_web_acl" "WAF_PROD" {
  name        = var.name_waf_prod
  description = var.description_waf_prod
  scope       = "REGIONAL"

  default_action {
    allow {}
  }
  
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "my-waf-metrics"
    sampled_requests_enabled   = true
  }

  # Existing rule
  rule {
    name     = var.rule_name
    priority = 1

    statement {
      managed_rule_group_statement {
        name        = var.rule_name
        vendor_name = "AWS"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = var.rule_name_cors
      sampled_requests_enabled   = true
    }
  }

  # New rule to protect against Log4j2 and other known bad inputs
  rule {
    name     = "protect-against-known-bad-inputs"
    priority = 2

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "protect-against-known-bad-inputs"
      sampled_requests_enabled   = true
    }
  }
}
