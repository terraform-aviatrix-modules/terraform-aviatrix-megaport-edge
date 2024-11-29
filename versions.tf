terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }
    megaport = {
      source  = "megaport/megaport"
      version = ">=1.2.0"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "1.2.1"
    }
  }
  required_version = ">= 1.0"
}
