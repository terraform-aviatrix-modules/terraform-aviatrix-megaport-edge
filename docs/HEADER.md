# terraform-aviatrix-megaport-edge-spoke

### Description
This module deploys the Aviatrix Edge Gateway in a Megaport location. It can take between 15 and 60 minutes after the deployment has completed, before you will see the gateway be in the "Up" state in the controller.

### Compatibility
Module | Terraform | Controller | Aviatrix Terraform provider | Megaport  Terraform provider 
:--- | :--- | :--- | :--- | :---
v1.1.1 | >=1.3 | 7.2 | ~> 3.2.0 | >= 1.2.1