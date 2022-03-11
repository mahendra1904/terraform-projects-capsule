
resource "aws_dynamodb_table" "pmc-dynamodb-table"{
    name =  "${var.name}"
    hash_key    =   "${var.hash_key}"
    read_capacity   =   "${var.read_capacity}"
    write_capacity   =   "${var.write_capacity}"

attribute{
    name    =   "${var.hash_key}"
    type    =   "S"
}
}

resource "aws_dynamodb_table_item" "pmc_item" {
  table_name = aws_dynamodb_table.pmc-dynamodb-table.name
  hash_key   = aws_dynamodb_table.pmc-dynamodb-table.hash_key #"${var.hash_key}"

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
