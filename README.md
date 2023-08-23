# example-s3-localstack

This repo is a follow-along repo to experiment and learn about S3.

Requirements:
- Docker & docker-compose
- awslocal
- Terraform and tflocal 

## Localstack
This is the primary tech that we'll be exploring here. It helps you simulate an AWS environment locally. It has a fair amount of AWS's features mocked out locally for you to use.

## Terraform
To show off some of what localstack can achieve, this project also automates the initial setup in localstack. You could use localstack to test your Terraform setup or to keep local environments similar to other environments.

## awslocal

awslocal is just a wrapper around the `aws` CLI.

Instead of writing this:
`aws --endpoint-url=http://localhost:4566 kinesis list-streams`

You can write this:
`awslocal kinesis list-streams`

For our purposes, we'll be sticking with S3 commands.