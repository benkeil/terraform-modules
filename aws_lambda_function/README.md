# aws_lambda_function

## Usage

```terraform
module "my_aws_lambda_function" {
  source = "git@github.com:benkeil/terraform-modules.git//aws_lambda_function/"
  name   = "templates"
  tags   = "${local.tags}"
}
```

## Inputs

|Name|Description|Type|Default|Required|
|---|---|---|---|
|aws_region|The AWS region|`string`|`eu-central-1`|false|
|service_name|The service name the lambda belongs to|`string`||true|
|function_name|The name of the lambda|`string`||true|
|description|A description what the lambda does|`string`||false|
|environment|Environment variables|`map`|`{}`|false|

## Outputs

|variable|description|
|---|---|
|arn|the arn of the created resource|
|function_name|the name of the created lambda function|