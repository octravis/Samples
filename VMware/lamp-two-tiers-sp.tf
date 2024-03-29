# This is a terraform generated template generated from twovmfinal

##############################################################
# Keys - CAMC (public/private) & optional User Key (public)
##############################################################
variable "allow_unverified_ssl" {
  description = "Communication with vsphere server with self signed certificate"
  default     = "true"
}



##############################################################
# Define the vsphere provider
##############################################################
provider "vsphere" {
  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version              = "~> 1.3"
}

##############################################################
# Define pattern variables
##############################################################
##############################################################
# Vsphere data for provider
##############################################################
data "vsphere_datacenter" "mariadb_vm_datacenter" {
  name = "${var.mariadb_vm_datacenter}"
}

data "vsphere_datastore" "mariadb_vm_datastore" {
  name          = "${var.mariadb_vm_root_disk_datastore}"
  datacenter_id = "${data.vsphere_datacenter.mariadb_vm_datacenter.id}"
}

data "vsphere_resource_pool" "mariadb_vm_resource_pool" {
  name          = "${var.mariadb_vm_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.mariadb_vm_datacenter.id}"
}

data "vsphere_network" "mariadb_vm_network" {
  name          = "${var.mariadb_vm_network_interface_label}"
  datacenter_id = "${data.vsphere_datacenter.mariadb_vm_datacenter.id}"
}

data "vsphere_virtual_machine" "mariadb_vm_template" {
  name          = "${var.mariadb_vm_image}"
  datacenter_id = "${data.vsphere_datacenter.mariadb_vm_datacenter.id}"
}

##############################################################
# Vsphere data for provider
##############################################################
data "vsphere_datacenter" "php_vm_datacenter" {
  name = "${var.php_vm_datacenter}"
}

data "vsphere_datastore" "php_vm_datastore" {
  name          = "${var.php_vm_root_disk_datastore}"
  datacenter_id = "${data.vsphere_datacenter.php_vm_datacenter.id}"
}

data "vsphere_resource_pool" "php_vm_resource_pool" {
  name          = "${var.php_vm_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.php_vm_datacenter.id}"
}

data "vsphere_network" "php_vm_network" {
  name          = "${var.php_vm_network_interface_label}"
  datacenter_id = "${data.vsphere_datacenter.php_vm_datacenter.id}"
}

data "vsphere_virtual_machine" "php_vm_template" {
  name          = "${var.php_vm_image}"
  datacenter_id = "${data.vsphere_datacenter.php_vm_datacenter.id}"
}

##### Image Parameters variables #####
#Variable : mariadb_vm_name
variable "mariadb_vm_name" {
  type        = "string"
  description = "Generated"
  default     = "mariadb-vm"
}

#Variable : php_vm_name
variable "php_vm_name" {
  type        = "string"
  description = "Generated"
  default     = "php-vm"
}

#########################################################
##### Resource : mariadb_vm
#########################################################

variable "mariadb_user" {
  description = "User to be added into db and sshed into servers"
  default     = "camuser"
}

variable "mariadb_ssh_user" {
  description = "The user for ssh connection to mariadb server, which is default in template"
  default     = "root"
}

variable "php_ssh_user" {
  description = "The user for ssh connection to php server, which is default in template"
  default     = "root"
}

variable "mariadb_ssh_user_password" {
  description = "The user password for ssh connection to mariadb server, which is default in template"
}

variable "php_ssh_user_password" {
  description = "The user password for ssh connection to mariadb server, which is default in template"
}

variable "mariadb_pwd" {
  description = "User password for cam user; It should be alphanumeric with length in [8,16]"
}

variable "mariadb_vm_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "mariadb_vm_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "mariadb_vm_domain" {
  description = "Domain Name of virtual machine"
}

variable "mariadb_vm_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
  default     = "1"
}

variable "mariadb_vm_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
  default     = "1024"
}

variable "mariadb_vm_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "mariadb_vm_resource_pool" {
  description = "Target vSphere Resource Pool to host the virtual machine"
}

variable "mariadb_vm_dns_suffixes" {
  type        = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "mariadb_vm_dns_servers" {
  type        = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "mariadb_vm_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "mariadb_vm_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "mariadb_vm_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "mariadb_vm_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "mariadb_vm_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
  default     = "vmxnet3"
}

variable "mariadb_vm_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "mariadb_vm_root_disk_type" {
  type        = "string"
  description = "Type of template disk volume"
  default     = "eager_zeroed"
}

variable "mariadb_vm_root_disk_controller_type" {
  type        = "string"
  description = "Type of template disk controller"
  default     = "scsi"
}

variable "mariadb_vm_root_disk_keep_on_remove" {
  type        = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
  default     = "false"
}

variable "mariadb_vm_root_disk_size" {
  description = "Size of template disk volume. Should be equal to template's disk size"
  default     = "25"
}

variable "mariadb_vm_image" {
  description = "Operating system image id / template that should be used when creating the virtual image"
}

module "provision_proxy_mariadb_vm" {
  source 							= "git::https://7f59d0c6b3f033ac0a53141b4fb85eace2c34570@github.com/IBM-CAMHub-Open/terraform-modules.git?ref=1.0//vmware/proxy"
  ip                  = "${var.mariadb_vm_ipv4_address}"
  id									= "${vsphere_virtual_machine.mariadb_vm.id}"
  ssh_user     				= "${var.mariadb_ssh_user}"
  ssh_password 				= "${var.mariadb_ssh_user_password}"  
  http_proxy_host     = "${var.http_proxy_host}"
  http_proxy_user     = "${var.http_proxy_user}"
  http_proxy_password = "${var.http_proxy_password}"
  http_proxy_port     = "${var.http_proxy_port}"
  enable							= "${ length(var.http_proxy_host) > 0 ? "true" : "false"}"
}

# vsphere vm
resource "vsphere_virtual_machine" "mariadb_vm" {
  name             = "${var.mariadb_vm_name}"
  folder           = "${var.mariadb_vm_folder}"
  num_cpus         = "${var.mariadb_vm_number_of_vcpu}"
  memory           = "${var.mariadb_vm_memory}"
  resource_pool_id = "${data.vsphere_resource_pool.mariadb_vm_resource_pool.id}"
  datastore_id     = "${data.vsphere_datastore.mariadb_vm_datastore.id}"
  guest_id         = "${data.vsphere_virtual_machine.mariadb_vm_template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.mariadb_vm_template.scsi_type}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.mariadb_vm_template.id}"

    customize {
      linux_options {
        domain    = "${var.mariadb_vm_domain}"
        host_name = "${var.mariadb_vm_name}"
      }

      network_interface {
        ipv4_address = "${var.mariadb_vm_ipv4_address}"
        ipv4_netmask = "${var.mariadb_vm_ipv4_prefix_length}"
      }

      ipv4_gateway    = "${var.mariadb_vm_ipv4_gateway}"
      dns_suffix_list = "${var.mariadb_vm_dns_suffixes}"
      dns_server_list = "${var.mariadb_vm_dns_servers}"
    }
  }

  network_interface {
    network_id   = "${data.vsphere_network.mariadb_vm_network.id}"
    adapter_type = "${var.mariadb_vm_adapter_type}"
  }

  disk {
    label          = "${var.mariadb_vm_name}0.vmdk"
    size           = "${var.mariadb_vm_root_disk_size}"
    keep_on_remove = "${var.mariadb_vm_root_disk_keep_on_remove}"
    datastore_id   = "${data.vsphere_datastore.mariadb_vm_datastore.id}"
  }
}

#########################################################
##### Resource : php_vm
#########################################################

variable "php_vm_folder" {
  description = "Target vSphere folder for virtual machine"
}

variable "php_vm_datacenter" {
  description = "Target vSphere datacenter for virtual machine creation"
}

variable "php_vm_domain" {
  description = "Domain Name of virtual machine"
}

variable "php_vm_number_of_vcpu" {
  description = "Number of virtual CPU for the virtual machine, which is required to be a positive Integer"
  default     = "1"
}

variable "php_vm_memory" {
  description = "Memory assigned to the virtual machine in megabytes. This value is required to be an increment of 1024"
  default     = "1024"
}

variable "php_vm_cluster" {
  description = "Target vSphere cluster to host the virtual machine"
}

variable "php_vm_resource_pool" {
  description = "Target vSphere Resource Pool to host the virtual machine"
}

variable "php_vm_dns_suffixes" {
  type        = "list"
  description = "Name resolution suffixes for the virtual network adapter"
}

variable "php_vm_dns_servers" {
  type        = "list"
  description = "DNS servers for the virtual network adapter"
}

variable "php_vm_network_interface_label" {
  description = "vSphere port group or network label for virtual machine's vNIC"
}

variable "php_vm_ipv4_gateway" {
  description = "IPv4 gateway for vNIC configuration"
}

variable "php_vm_ipv4_address" {
  description = "IPv4 address for vNIC configuration"
}

variable "php_vm_ipv4_prefix_length" {
  description = "IPv4 prefix length for vNIC configuration. The value must be a number between 8 and 32"
}

variable "php_vm_adapter_type" {
  description = "Network adapter type for vNIC Configuration"
  default     = "vmxnet3"
}

variable "php_vm_root_disk_datastore" {
  description = "Data store or storage cluster name for target virtual machine's disks"
}

variable "php_vm_root_disk_type" {
  type        = "string"
  description = "Type of template disk volume"
  default     = "eager_zeroed"
}

variable "php_vm_root_disk_controller_type" {
  type        = "string"
  description = "Type of template disk controller"
  default     = "scsi"
}

variable "php_vm_root_disk_keep_on_remove" {
  type        = "string"
  description = "Delete template disk volume when the virtual machine is deleted"
  default     = "false"
}

variable "php_vm_root_disk_size" {
  description = "Size of template disk volume. Should be equal to template's disk size"
  default     = "25"
}

variable "php_vm_image" {
  description = "Operating system image id / template that should be used when creating the virtual image"
}

module "provision_proxy_php_vm" {
  source 							= "git::https://7f59d0c6b3f033ac0a53141b4fb85eace2c34570@github.com/IBM-CAMHub-Open/terraform-modules.git?ref=1.0//vmware/proxy"
  ip                  = "${var.php_vm_ipv4_address}"
  id									= "${vsphere_virtual_machine.php_vm.id}"
  ssh_user     				= "${var.php_ssh_user}"
  ssh_password 				= "${var.php_ssh_user_password}"
  http_proxy_host     = "${var.http_proxy_host}"
  http_proxy_user     = "${var.http_proxy_user}"
  http_proxy_password = "${var.http_proxy_password}"
  http_proxy_port     = "${var.http_proxy_port}"
  enable							= "${ length(var.http_proxy_host) > 0 ? "true" : "false"}"
}

# vsphere vm
resource "vsphere_virtual_machine" "php_vm" {
  depends_on = ["vsphere_virtual_machine.mariadb_vm"]

  name             = "${var.php_vm_name}"
  folder           = "${var.php_vm_folder}"
  num_cpus         = "${var.php_vm_number_of_vcpu}"
  memory           = "${var.php_vm_memory}"
  resource_pool_id = "${data.vsphere_resource_pool.php_vm_resource_pool.id}"
  datastore_id     = "${data.vsphere_datastore.php_vm_datastore.id}"
  guest_id         = "${data.vsphere_virtual_machine.php_vm_template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.php_vm_template.scsi_type}"

  clone {
    template_uuid = "${data.vsphere_virtual_machine.php_vm_template.id}"

    customize {
      linux_options {
        domain    = "${var.php_vm_domain}"
        host_name = "${var.php_vm_name}"
      }

      network_interface {
        ipv4_address = "${var.php_vm_ipv4_address}"
        ipv4_netmask = "${var.php_vm_ipv4_prefix_length}"
      }

      ipv4_gateway    = "${var.php_vm_ipv4_gateway}"
      dns_suffix_list = "${var.php_vm_dns_suffixes}"
      dns_server_list = "${var.php_vm_dns_servers}"
    }
  }

  network_interface {
    network_id   = "${data.vsphere_network.php_vm_network.id}"
    adapter_type = "${var.php_vm_adapter_type}"
  }

  disk {
    name           = "${var.php_vm_name}.vmdk"
    size           = "${var.php_vm_root_disk_size}"
    keep_on_remove = "${var.php_vm_root_disk_keep_on_remove}"
    datastore_id   = "${data.vsphere_datastore.php_vm_datastore.id}"
  }
}

resource "camc_scriptpackage" "install_mariadb" {	
	depends_on = ["module.provision_proxy_mariadb_vm"]
  	program = ["/bin/bash", "/root/install_mariadb_script.sh"]
  	on_create = true
  	remote_host = "${vsphere_virtual_machine.mariadb_vm.clone.0.customize.0.network_interface.0.ipv4_address}"
  	remote_user = "${var.mariadb_ssh_user}"
  	remote_password = "${var.mariadb_ssh_user_password}"
  	source = "https://raw.githubusercontent.com/bhadrim/Samples/master/VMware/scripts/install_mariadb_script.sh"
	source_user = "bhadrim"
	source_password = "Github4madapusi"
  	destination = "/root/install_mariadb_script.sh"	
	query = {
    		USER = "${var.mariadb_user}"
		PASSWORD = "${var.mariadb_pwd}"
		HOST = "${vsphere_virtual_machine.php_vm.clone.0.customize.0.network_interface.0.ipv4_address}"
  	}	
}
	
output "Install Maria Status"{
  value = "${camc_scriptpackage.install_mariadb.result["status"]}"
}	
	
#output "Install Maria logs"{
#  value = "${camc_scriptpackage.install_mariadb.result["stdout"]}"
#}	
	
	
resource "camc_scriptpackage" "get_mariadb_logs" {
 	depends_on = ["camc_scriptpackage.install_mariadb"]	
  	program = ["cat", "${camc_scriptpackage.install_mariadb.result["loglocation"]}"]
  	on_create = true
  	remote_host = "${vsphere_virtual_machine.mariadb_vm.clone.0.customize.0.network_interface.0.ipv4_address}"
  	remote_user = "${var.mariadb_ssh_user}"
  	remote_password = "${var.mariadb_ssh_user_password}"	
}

output "Install Maria logs"{
  value = "${camc_scriptpackage.get_mariadb_logs.result["stdout"]}"
}	
	
resource "camc_scriptpackage" "install_php" {
  	depends_on = ["camc_scriptpackage.install_mariadb", "module.provision_proxy_php_vm"]
 	program = ["/bin/bash", "/root/install_php_script.sh", "${vsphere_virtual_machine.php_vm.clone.0.customize.0.network_interface.0.ipv4_address}", "${vsphere_virtual_machine.mariadb_vm.clone.0.customize.0.network_interface.0.ipv4_address}", "${var.mariadb_user}", "${var.mariadb_pwd}"]
  	on_create = true
  	remote_host = "${vsphere_virtual_machine.php_vm.clone.0.customize.0.network_interface.0.ipv4_address}"
  	remote_user = "${var.php_ssh_user}"
  	remote_password = "${var.php_ssh_user_password}"
  	source = "https://raw.githubusercontent.com/bhadrim/Samples/master/VMware/scripts/install_php_script.sh"
	source_user = "bhadrim"
	source_password = "Github4Madapusi"	
  	destination = "/root/install_php_script.sh"	
}
	
output "Install PHP logs"{
  value = "${camc_scriptpackage.install_php.result["stdout"]}"
}		

output "application_url" {
  value = "http://${vsphere_virtual_machine.php_vm.clone.0.customize.0.network_interface.0.ipv4_address}/test.php"
}

output "MariaDB address" {
  value = "${vsphere_virtual_machine.mariadb_vm.clone.0.customize.0.network_interface.0.ipv4_address}"
}
