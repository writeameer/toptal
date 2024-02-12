data "local_file" "configdata" {
  filename = "${path.module}/configdata.json" 
}

locals {
  config_data = jsondecode(data.local_file.configdata.content)
}