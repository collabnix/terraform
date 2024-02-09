output "Instance_Name" {
  value= aws_instance.instance.Tags["Name"]
}
