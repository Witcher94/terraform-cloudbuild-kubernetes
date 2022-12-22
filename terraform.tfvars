#name = "aafs"
#description = ""
#routing_mode = ""
#auto_create_subnetworks = false
#delete_default_internet_gateway_routes = true
#mtu = 0
#allocate_option = ""
#ip_ranges_to_nat = ""
#subnets = {
#      subnet-1 = {
#      ip                           = "10.20.30.0/24"
#      region                       = "europe-west3"
#      name                         = "public"
#      subnet_flow_logs             = "true"
#      subnet_flow_logs_interval    = "INTERVAL_10_MIN"
#      subnet_flow_logs_sampling    = 0.7
#      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
#      subnet_flow_logs_filter_expr = "true"
#    }
#}
#rules = {
#    firewall-rule-1 = {
#      name                    = "allow-http"
#      description             = null
#      direction               = "INGRESS"
#      priority                = 1000
#      ranges                  = ["10.20.30.0/24"]
#      source_tags             = null
#      source_service_accounts = null
#      target_tags             = null
#      target_service_accounts = null
#      allow = [
#        {
#          protocol = "tcp"
#          ports    = ["6379"]
#        }
#      ]
#      deny = []
#    },
#    firewall-rule-2 = {
#      name                    = "allow-iap"
#      description             = null
#      direction               = "INGRESS"
#      priority                = 1000
#      ranges                  = ["35.235.240.0/20"]
#      source_tags             = null
#      source_service_accounts = null
#      target_tags             = null
#      target_service_accounts = null
#      allow                   = [
#        {
#          protocol = "tcp"
#          ports    = ["22"]
#        }
#      ]
#      deny = []
#    }
#}
#account_id = ""
#roles = [""]
#members = [""]
#secret_id = ""
#length = 0
#min_upper = 0
#min_lower = 0
#min_numeric = 0
#min_special = 0
#labels = ""
#remove-default-node-pool = true
#initial-node-count = 1
#node-count = 1
#preemptible = false
#machine-type = "e2-micro"