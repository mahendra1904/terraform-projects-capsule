
# resource to create a dynamodb table
resource "aws_dynamodb_table" "pmc-dynamodb-table"{
    name =  "${var.name}"
    hash_key    =   "${var.hash_key}" # primary key of the dynamodb table
    read_capacity   =   "${var.read_capacity}" # read capacity of the table
    write_capacity   =   "${var.write_capacity}" # write capacity of the table

attribute{
    name    =   "${var.hash_key}"
    type    =   "S" # type of primary key
}
}

# resource to insert the data in the dynamodb table
resource "aws_dynamodb_table_item" "pmc_item" {
  table_name = aws_dynamodb_table.pmc-dynamodb-table.name
  hash_key   = aws_dynamodb_table.pmc-dynamodb-table.hash_key #"${var.hash_key}"

# the given below data will be store in the dynamodb table
 item = <<ITEM
{ 
  "${var.hash_key}": {"S": "G101"},
  "one": {"S": "11111"},
  "two": {"S": "22222"},
  "three": {"S": "33333"},
  "four": {"S": "44444"}
}
ITEM
}

