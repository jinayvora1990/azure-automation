variable "seed-value" {
  type        = string
  description = "The seed value"
  default     = null
}

resource "random_string" "unique-id" {
  length      = 8
  min_numeric = 2
  min_lower   = 2
  upper       = false
  special     = false
  keepers     = var.seed-value != null ? { seed = var.seed-value } : null
}

output "result" {
  value = random_string.unique-id.result
}