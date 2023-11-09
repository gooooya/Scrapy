REM Start Docker daemon
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"

REM Wait Docker Desktop
timeout /t 10

REM Copy in docker context
set SOURCE_FILE=..\Scrapy\scrapytest\scrapytest\spiders\my_scrapy.py
set DEST_DIR=tmp

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

copy "%SOURCE_FILE%" "%DEST_DIR%"

REM error check
if %ERRORLEVEL% neq 0 (
    echo coppy error
    exit /b %ERRORLEVEL%
)
