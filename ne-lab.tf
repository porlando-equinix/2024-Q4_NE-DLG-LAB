terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "2.10.0"
    }
  }
}

provider "equinix" {
  #auth_token = "your metal API key"
  client_id = "M1eXL7cUJEAynpijfdiEvocASSh58V60xzFfBN6B9AcpJTIh"
  client_secret = "zzXJq8GQeNsdLK3Y7TeTf6WS1nEyiG5QSZRhGaCYFNhBnuYqZAgsAGWkYw8vynsN"

}

resource "equinix_network_device" "ne1" {
  name                 = "pat-ne-tf-lab1"
  metro_code           = "TR"
  type_code            = "C8000V"
  self_managed         = true
  byol                 = true
  package_code         = "network-essentials"
  notifications        = ["porlando@equinix.com"]
  hostname             = "porlando"
  account_number       = "135888"
  version              = "17.09.04a"
  core_count           = 2
  term_length          = 1
  additional_bandwidth = 0
  #acl_template_id      = "M1eXL7cUJEAynpijfdiEvocASSh58V60xzFfBN6B9AcpJTIh"

  ssh_key {
    username = "porlando"
    key_name = "PatO-key"
    }

}
resource "equinix_network_device" "ne2" {
  name                 = "pat-ne-tf-lab2"
  metro_code           = "TR"
  type_code            = "C8000V"
  self_managed         = true
  byol                 = true
  package_code         = "network-essentials"
  notifications        = ["porlando@equinix.com"]
  hostname             = "porlando"
  account_number       = "135888"
  version              = "17.09.04a"
  core_count           = 2
  term_length          = 1
  additional_bandwidth = 0
  #acl_template_id      = "M1eXL7cUJEAynpijfdiEvocASSh58V60xzFfBN6B9AcpJTIh"
  ssh_key {
    username = "porlando"
    key_name = "PatO-key"
    }

}

resource "equinix_network_device_link" "dlg1" {
  name   = "pat-ne-tf-dlg"
  project_id  = "f1a596ed-d24a-497c-92a8-44e0923cee62"
  device {
    id           = equinix_network_device.ne1.uuid
    interface_id = 5
  }
  device {
    id           = equinix_network_device.ne2.uuid
    interface_id = 5
  }
  metro_link {
    account_number  = equinix_network_device.ne1.account_number
    metro_code  = "TR"
    throughput      = "50"
    throughput_unit = "Mbps"
  }
}

