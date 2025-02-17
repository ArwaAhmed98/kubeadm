variable vpc_cidr {
    type = string
    # default = "10.0.0.0/16" 
    description = "this is the cidr of the vpc"
  
}
variable name {
    type = string
}
variable public_sub1_cidr {
    type = string
  
}

variable public_sub2_cidr {
    type = string
  
}
variable private_sub1_cidr {
    type = string
  
}
variable private_sub2_cidr {
    type = string
  
}   
variable region{
    type=string
}
