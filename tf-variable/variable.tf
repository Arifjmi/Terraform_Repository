variable "instance_type" {
description = "What type of instance type?"
type = string
default = "t2.micro"

validation {   // Condition Not allowed any type of instance except t2 and t3
    condition = var.instance_type=="t2.micro" || var.instance_type=="t3.micro"
    error_message = "Only t2 and t3 micro allowed"
  }

}
// root block device( we combined it below)
    // variable "root_volume_size" {
	//   type = number
	//   default = 20
    // }
    //  variable "root_volume_type" {
	//    type = string
	//    default = "gp2"
    //  }

// above two variable is the part of one block so we can combine it( variable_root_volume_size and root_volume_type)

variable "root_volume_config" {
	type = object({
	  v_size = number
	  v_type = string
	})
	default = {
	  v_size = 20
	  v_type = "gp2"
	}
  }

  variable "additional_tag" {
	type = map(string)   //expicting key=value formate
	default =  {}
  }

