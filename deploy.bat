REM @echo off

REM Skip build if both zip files exist
IF EXIST "tmp\scrapy.zip" (
    IF EXIST "tmp\layer.zip" (
        ECHO Skip build
        GOTO EndBuild
    )
)

REM Build Docker image if either of the zip files does not exist
cd lambda_layer
CALL build.bat
cd ..

:EndBuild



REM Initialize Terraform
cd Terraform
terraform init

REM Apply Terraform save state
terraform apply -auto-approve



cd ..