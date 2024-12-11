terraform {
  required_providers {
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "~>3.1.0"
    }
    megaport = {
      source  = "megaport/megaport"
      version = ">=1.2.1"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "1.2.1"
    }
  }
  required_version = ">= 1.3"
}
