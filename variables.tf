variable "api_key" {
  type = string
  description = "API Key Id from Intersight"
}
variable "secretkey" {
  type = string
  description = "The path to your secretkey for Intersight OR the your secret key as a string"
}
variable "organization" {
  type = string
  description = "Organization Name"
  default = "default"
}
variable "password" {
    type = string
    description = "Default Password"
}
variable "env" {
    type = string
    description = "Environment"
}
variable "kvmdipgw" {
    type = string
    description = "KVM IP GW"
}
variable "kvmdipmask" {
    type = string
    description = "KVM IP Netmask"
}
variable "kvmdipfrom" {
    type = string
    description = "KVM IP From"
}
variable "kvmdipto" {
    type = string
    description = "KVM IP To"
}
variable "macafrom" {
    type = string
    description = "Mac Pool A from"
}
variable "macato" {
    type = string
    description = "Mac Pool A to"
}
variable "macbfrom" {
    type = string
    description = "Mac Pool B from"
}
variable "macbto" {
    type = string
    description = "Mac Pool B to"
}
variable "iqnprefix" {
    type = string
    description = "IQN Prefix"
}
variable "iqnsuffix" {
    type = string
    description = "IQN Sufix"
}
variable "uuidfrom" {
    type = string
    description = "UUID From Pool"
}
variable "uuidto" {
    type = string
    description = "UUID To Pool"
}
variable "primarydns" {
    type = string
    description = "Primary DNS"
}
variable "secondarydns" {
    type = string
    description = "Secondary DNS"
}
variable "vmvlan" {
    type = string
    description = "VLAN for VM's"
}