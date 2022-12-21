variable "name" {
  type = string
}
variable "region" {
  type = string
}
variable "remove-default-node-pool" {
  type = bool
}
variable "initial-node-count" {
  type = number
}
variable "node-count" {
  type = number
}
variable "preemptible" {
  type = bool
}
variable "machine-type" {
  type = string
}
#variable "service-account" {
#  type = string
#}
variable "secret" {
  type = string
}
variable "network" {
  type = string
}
variable "subnet" {
  type = string
}