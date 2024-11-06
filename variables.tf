variable "prevent_destroy" {
  description = "set to false to allow destruction of le blób"
  type        = bool
  default     = true
}

variable "tenant_id" {
  type    = string
  default = ""
}