# Optionally, you can have this open in another window and omit -d to see the log output.
docker-compose up -d

# Initialize Terraform (creates local files to keep track of state)
tflocal init

# Create the S3 Bucket via main.tf
tflocal apply

# You may need to login first due to how our AWS SSO works.
# aws sso login
awslocal s3 ls


# visit http://mysecretfiles.s3-website.localhost.localstack.cloud:4566/ in your browser

awslocal s3 cp copy-me-index.html s3://mysecretfiles/index.html

# visit http://mysecretfiles.s3-website.localhost.localstack.cloud:4566/ in your browser