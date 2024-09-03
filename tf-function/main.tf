terraform {}

locals {
	value = "Hello world!"
}

variable "string_list" {
	type = list(string)
	default = ["server1","server2","server3"]
}

output "output" {
	//value = lower(local.value)
	//value = startswith(local.value,"world")
	//value = split (" ",local.value)
	 //value = min(1,2,3,4,5)
	 //value = max(1,2,3,4,5)
     //value = abs(-15.123)
	 //value = length(var.string_list)
	 //value = join(";",var.string_list)
	 //value = contains(var.string_list,"server")
	 value = toset(var.string_list)


}

