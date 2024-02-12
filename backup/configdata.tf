data "local_file" "network_json" {
  filename = "${path.module}/configdata.json" // Replace with your file path
}

locals {
  config_data = jsondecode(data.local_file.network_json.content)
}
