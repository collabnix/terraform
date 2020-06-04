variable "gcp_project_id" {
  description = "This is a GCP Project id"
  type        = string
}

variable "machine_type" {
  description = "This is the type of the machine"
  type        = string
  default     = "n1-standard-2"
}

variable "gcp_compute_zone" {
  description = "This is the zone in which the compute instances will be created"
  type        = string
  default     = "australia-southeast1-a"
}