variable "aws_access_key" {
    default = "AKIA5CHGDFVPAE7LSJMI"
}
variable "aws_secret_key" {
    default = "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"
}
variable "region" {
    default = "ap-southeast-1"
}
variable "availability_zone" {
    default = "ap-southeast-1"
}
variable "ami" {
    default = "ami-06df38320cecdd700"
}
variable "instance_type" {
    default = "t2.medium"
}
variable "root_volume_size" {
    default = 8
}
variable "instance_count" {
    default = 1
}
variable "delete_on_termination" {
    default = true
}
variable "volume_size" {
    default = 20
}
variable "volume_type" {
    default = "gp2"
}
variable "key_name" {
    default = "jenkins"
}
variable "vpc_security_group_ids" {
    default = ["sg-0d2f5f88d9fabddb5"]
}
variable "associate_public_ip_address" {
    default = true
}
variable "tags" {
    type = map(string)
    default = {
    "name" = "cilist"
    "purpose" = "praktikum-sekolah-devops"
    "env" = "dev"
    }
}