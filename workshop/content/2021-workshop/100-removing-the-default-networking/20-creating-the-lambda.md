+++
title = "Creating the Lambda"
weight = 20
home_region = "eu-west-1"
codecommit_repo_name = "delete-default-networking-function" 
codecommit_repo_branch = "main" 
product_name = "delete-default-networking-function"
product_version = "v1"
+++
---

## What are we going to do?

We are going to perform the following steps:

- Define a stack
- Add the source code for our product

The hub AWS Account is the source of truth for our stacks. Spoke AWS accounts are consumers of these stacks, you can think of them as accounts that need governance controls applied. For this workshop, we are using the same account as both the hub and spoke for simplicity; in a multi-account setup, these could be separate AWS Accounts and Regions. 

## Step by step guide

Here are the steps you need to follow to "{{% param title %}}"

### Define a stack

- Navigate to the {{% service_catalog_factory_code_commit_repo_link %}}  

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:
 
  <figure>
   {{< highlight js >}}
Schema: factory-2019-04-01
Stacks:
  - Name: "delete-default-networking-function"
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "delete-default-networking-function"
            BranchName: "main"
   {{< / highlight >}}
  </figure>

 
- Set the *File name* to *stacks/network-workshop.yaml*

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}


- Click the *Commit changes* button:

{{< figure src="/tasks/CommitChanges.png" >}}


#### What did we just do?

The YAML file we created in the CodeCommit repository told the framework to:

- create a pipeline that will take source code from a branch named {{% param codecommit_repo_branch %}} of CodeCommit repo named {{% param codecommit_repo_name %}}

#### Verify the change worked

Once you have made your changes the {{% service_catalog_factory_pipeline_link %}} should have run. If you were very quick in making the change, the pipeline 
may still be running.  If it has not yet started feel free to the hit the *Release change* button.

Once it has completed it should show the *Source* and *Build* stages in green to indicate they have completed 
successfully:

{{< figure src="/tasks/SuccessfulFactoryRun.png" >}}

{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.
{{% /notice %}}


### Add the source code for our product

When you configured your product version, you specified the following version: 

 <figure>
  {{< highlight js >}}
    Versions:
      - Name: "v1"
        Active: True
        Source:
          Provider: "CodeCommit"
          Configuration:
            RepositoryName: "delete-default-networking-function"
            BranchName: "main"
  {{< / highlight >}}
 </figure>


This tells the framework the source code for the product comes from the _{{% param codecommit_repo_branch %}}_ branch of a
_CodeCommit_ repository of the name _{{% param codecommit_repo_name %}}_. 

We now need to create the CodeCommit repository and add the AWS CloudFormation template we are going to use for our
product.

- Navigate to {{% codecommit_link %}}

- Click *Create repository*

{{< figure src="/tasks/CreateRepository.png" >}}

- Input the name `{{% param codecommit_repo_name %}}`

{{< figure src="/tasks/InputTheName.png" >}}

- Click *Create*

{{< figure src="/tasks/ClickCreate.png" >}}

- Scroll down to the bottom of the page and hit the *Create file* button

{{< figure src="/tasks/create_file.png" >}}

- Copy the following snippet into the main input field:

 <figure>
 {{< highlight js >}}

AWSTemplateFormatVersion: "2010-09-09"
Description: |
  Deletes the following default networking components from AWS Accounts:
  1) Deletes the internet gateway
  2) Deletes the subnets
  4) Deletes the network access lists
  5) Deletes the security groups
  6) Deletes the default VPC
  {"framework": "servicecatalog-products", "role": "product", "product-set": "delete-default-vpc", "product": "delete-default-vpc", "version": "v1"}
Parameters:
  DeleteDefaultNetworkingRoleNameToAssume:
    Description: "Name of the IAM Role that will be assumed in the spoke account to remove networking"
    Type: String
    Default: "servicecatalog-puppet/PuppetRole"
  DeleteDefaultVPCLambdaExecutionIAMRoleName:
    Description: "Name of the IAM Role that will be created to execute the lambda function"
    Type: String
    Default: "DeleteDefaultVPCLambdaExecution"
  DeleteDefaultVPCLambdaExecutionIAMRolePath:
    Description: "The path for the IAM Role that will be created to execute the lambda function"
    Type: String
    Default: "/DeleteDefaultVPCLambdaExecution/"
  DeleteDefaultNetworkingLambdaFunctionName:
    Description: "The name to give the function that deletes the default networking resources"
    Type: String
    Default: "DeleteDefaultNetworking"

Resources:
  DefaultVpcDeletionRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: !Ref DeleteDefaultVPCLambdaExecutionIAMRoleName
      Path: !Ref DeleteDefaultVPCLambdaExecutionIAMRolePath
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Action: sts:AssumeRole
            Principal:
              Service: lambda.amazonaws.com
      Policies:
        - PolicyName: Organizations
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Action:
                  - "sts:AssumeRole"
                Resource: !Sub 'arn:${AWS::Partition}:iam::*:role/${DeleteDefaultNetworkingRoleNameToAssume}'
              - Effect: Allow
                Action:
                  - "ec2:DescribeInternetGateways"
                  - "ec2:DetachInternetGateway"
                  - "ec2:DeleteInternetGateway"
                  - "ec2:DescribeSubnets"
                  - "ec2:DeleteSubnet"
                  - "ec2:DescribeRouteTables"
                  - "ec2:DeleteRouteTable"
                  - "ec2:DescribeNetworkAcls"
                  - "ec2:DeleteNetworkAcl"
                  - "ec2:DeleteSecurityGroup"
                  - "ec2:DeleteVpc"
                  - "ec2:DescribeRegions"
                  - "ec2:DescribeAccountAttributes"
                  - "ec2:DescribeNetworkInterfaces"
                  - "ec2:DescribeSecurityGroups"
                  - "ec2:DeleteSecurityGroup"
                  - "logs:CreateLogGroup"
                  - "logs:CreateLogStream"
                  - "logs:PutLogEvents"
                Resource: '*'

  Function:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: !Ref DeleteDefaultNetworkingLambdaFunctionName
      Handler: index.lambda_handler
      Runtime: python3.7
      Timeout: 600
      Role: !GetAtt DefaultVpcDeletionRole.Arn
      Environment:
        Variables:
          DeleteDefaultNetworkingRoleNameToAssume: !Ref DeleteDefaultNetworkingRoleNameToAssume
          Partition: !Sub '${AWS::Partition}'
      Code:
        ZipFile: |
          import boto3, logging, traceback, os
          from boto3 import Session
          logger = logging.getLogger()
          logger.setLevel(logging.INFO)
          logging.basicConfig(
              format='%(levelname)s %(threadName)s [%(filename)s:%(lineno)d] %(message)s',
              datefmt='%Y-%m-%d:%H:%M:%S',
              level=logging.INFO
          )
          def delete_igw(client, vpc_id):
              fltr = [{'Name': 'attachment.vpc-id', 'Values': [vpc_id]}]
              try:
                  igw = client.describe_internet_gateways(Filters=fltr)['InternetGateways']
                  if igw:
                      igw_id = igw[0]['InternetGatewayId']
                      client.detach_internet_gateway(InternetGatewayId=igw_id, VpcId=vpc_id)
                      client.delete_internet_gateway(InternetGatewayId=igw_id)
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def delete_subnets(client):
              try:
                  subs = client.describe_subnets()['Subnets']
                  if subs:
                      for sub in subs:
                          sub_id = sub['SubnetId']
                          client.delete_subnet(SubnetId=sub_id)
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def delete_rtbs(client):
              try:
                  rtbs = client.describe_route_tables()['RouteTables']
                  if rtbs:
                      for rtb in rtbs:
                          main = False
                          for assoc in rtb['Associations']:
                              main = assoc['Main']
                          if main:
                              continue
                          rtb_id = rtb['RouteTableId']
                          client.delete_route_table(RouteTableId=rtb_id)
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def delete_acls(client):
              try:
                  acls = client.describe_network_acls()['NetworkAcls']
                  if acls:
                      for acl in acls:
                          default = acl['IsDefault']
                          if default:
                              continue
                          acl_id = acl['NetworkAclId']
                          client.delete_network_acl(NetworkAclId=acl_id)
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def delete_sgps(client):
              try:
                  sgps = client.describe_security_groups()['SecurityGroups']
                  if sgps:
                      for sgp in sgps:
                          default = sgp['GroupName']
                          if default == 'default':
                              continue
                          sg_id = sgp['GroupId']
                          client.delete_security_group(GroupId=sg_id)
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def delete_vpc(client, vpc_id, region):
              try:
                  client.delete_vpc(VpcId=vpc_id)
                  logger.info('VPC {} has been deleted from the {} region.'.format(vpc_id, region))
                  return
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)
                  raise
          def lambda_handler(e, c):
              account_id=e.get("account_id")
              region=e.get("region")
              role_arn = f"arn:{os.getenv('Partition')}:iam::{account_id}:role/{os.getenv('DeleteDefaultNetworkingRoleNameToAssume')}"
              sts = Session().client('sts')
              assumed_role_object = sts.assume_role(
                  RoleArn=role_arn,
                  RoleSessionName="spoke",
              )
              credentials = assumed_role_object['Credentials']
              kwargs = {
                  "service_name": "ec2",
                  "aws_access_key_id": credentials['AccessKeyId'],
                  "aws_secret_access_key": credentials['SecretAccessKey'],
                  "aws_session_token": credentials['SessionToken'],
              }
              ec2 = Session().client(**kwargs, region_name=region)
              try:
                  attribs = ec2.describe_account_attributes(AttributeNames=['default-vpc'])['AccountAttributes']
                  vpc_id = attribs[0]['AttributeValues'][0]['AttributeValue']
                  if vpc_id == 'none':
                      logger.info('Default VPC not found in {}'.format(region))
                      return
                  # Since most resources are attached an ENI, this checks for additional resources
                  f = [{'Name': 'vpc-id', 'Values': [vpc_id]}]
                  eni = ec2.describe_network_interfaces(Filters=f)['NetworkInterfaces']
                  if eni:
                      logger.error('VPC {} has existing resources in the {} region.'.format(vpc_id, region))
                      return
                  delete_igw(ec2, vpc_id)
                  delete_subnets(ec2)
                  delete_rtbs(ec2)
                  delete_acls(ec2)
                  delete_sgps(ec2)
                  delete_vpc(ec2, vpc_id, region)
              except Exception as ex:
                  logger.error(ex)
                  traceback.print_tb(ex.__traceback__)

 {{< / highlight >}}
</figure>

 

- Set the *File name* to `stack.template.yaml`

- Set your *Author name*
- Set your *Email address*
- Set your *Commit message*

{{% notice tip %}}
Using a good / unique commit message will help you understand what is going on later.
{{% /notice %}}

Creating that file should trigger your 
{{% codepipeline_pipeline_link "stack--delete-default-networking-function-v1-pipeline" %}}.  

Once the pipeline has completed it should show the stages in green to indicate 
they have completed successfully:

{{< figure src="/tasks/SuccessfulFactoryProductRun.png" >}}

{{% notice tip %}}
You should see your commit message on this screen, it will help you know which version of ServiceCatalogFactory repository the 
pipeline is processing. 

{{% /notice %}}

{{% notice note %}}
The screenshots may differ slightly as the design of AWS CodePipeline changes.  You should see a pipeline where each 
stage is green.

{{% /notice %}}


You have now successfully created a stack! 

#### Verify the stack is present in Amazon S3

Now that you have verified the pipeline has run correctly you can go to Amazon S3 to view the stack.

- Navigate to [https://s3.console.aws.amazon.com/s3/home](https://s3.console.aws.amazon.com/s3/home)

- Select the bucket named sc-puppet-stacks-repository-<account_id>

- Navigate to stack/{{% param product_name %}}/{{% param product_version %}} where you should see an object named stack.template.yaml

