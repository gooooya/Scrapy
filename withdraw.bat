REM save bucket
aws s3 sync s3://my-scrapy-output buckup_data

REM delete bucket
aws s3 rm s3://my-scrapy-output --recursive

REM destroy
cd Terraform
terraform destroy --auto-approve

cd ..