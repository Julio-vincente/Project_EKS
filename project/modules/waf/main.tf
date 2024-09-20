resource "aws_waf_web_acl" "web_acl_prod" {
  name        = var.waf_prod
  metric_name = "webACL"
  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }
    priority = 1
    rule_id  = aws_waf_rule.sql_injection_rule.id
  }
}

resource "aws_wafregional_sql_injection_match_set" "sql_injection_protection" {
    name = var.sql_injection_protection
    sql_injection_match_tuple {
      text_transformation = "HTML_ENTITY_DECODE"
      field_to_match {
        type = "BODY"
      }
    }
}
    
}