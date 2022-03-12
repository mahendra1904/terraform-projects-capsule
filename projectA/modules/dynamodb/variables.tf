variable "name"{
    type =  string
    description = "name of the dynamodb table"

}

variable "hash_key"{
    type    =   string
    description     =   "it is unique identify the items in table"
}

variable "read_capacity"{
    type       = number  
    description     =   "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
}

variable "write_capacity"{
    type    =   number
    description     =   "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
}

# variable "region"{
#     type    =   string
#     description         =   "same replica of this table will be set in the other region"
# }
