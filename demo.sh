## 1. Introduction

# Optionally, you can have this open in another window and omit -d to see the log output.
docker-compose up -d

# Initialize Terraform (creates local files to keep track of state)
tflocal init

# Create the S3 Bucket via main.tf
tflocal apply

## 2. AWS S3 CLI and Localstack

# You may need to login first due to how our AWS SSO works.
# aws sso login
awslocal s3 ls

# visit http://examplebucket.s3-website.localhost.localstack.cloud:4566/ in your browser

awslocal s3 cp copy-me-index.html s3://examplebucket/index.html

# visit http://examplebucket.s3-website.localhost.localstack.cloud:4566/ in your browser

## 3. Python With Localstack/Cloudflare R2



# visit http://localhost:5000/index.html in your browser
awslocal s3 cp ./version-2-index.html s3://versionedexample/index.html

# visit http://localhost:5000/index.html in your browser
awslocal s3api list-object-versions --bucket versionedexample 
# visit http://localhost:5000/index.html?version=VERSION_ID in your browser