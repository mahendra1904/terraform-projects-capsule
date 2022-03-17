# aws lambda function that will trigger the s3 bucket when any object will be pushed in that bucket
import boto3 # install boto3 to run the python code in aws
from uuid import uuid4 # (Universal Unique Identifier ), is a python library which helps in generating random objects of 128 bits as ids
def lambda_handler(event, context): # define the function of python
    s3 = boto3.client("s3") 
    dynamodb = boto3.resource('dynamodb')
    for record in event['Records']:
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        size = record['s3']['object'].get('size', -1)
        event_name = record ['eventName']
        event_time = record['eventTime']
        dynamoTable = dynamodb.Table('pmc-tableA')
        #dynamoTable = dynamodb.Table('aws_dynamodb_table.pmc-dynamodb-table.name')
        dynamoTable.put_item(
            Item={'unique': str(uuid4()), 'Bucket': bucket_name, 'Object': object_key,'Size': size, 'Event': event_name, 'EventTime': event_time})
