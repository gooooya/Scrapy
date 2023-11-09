# 目的
suumoからマンションの販売情報を入手し、今後の物件探しに活用できるデータを取得すること。
    
# 構成図
![構成図](images/configuration_diagram.jpg)

# システム要件
以下の環境での動作を確認しました。
- **windows10**
- **Docker Desktop**
- **AWS CLI**
- **環境変数:**
  - AWS_ACCESS_KEY_ID AWSの公開鍵
  - AWS_SECRET_ACCESS_KEY AWSの秘密鍵
  - TF_VAR_bucket_name バケット名(任意)

# リポジトリの構成
- **Scrapy/**
  - scrapy startprojectで自動生成されたもの
- **Scrapy/Scrapy/scrapytest/scrapytest/spiders/my_scrapy.py**
  - spiderの処理定義およびハンドラ
- **Scrapy/Scrapy/scrapytest/scrapytest/spiders/Untitled.ipynb**
  - 動作確認用ノートブック
- **Terraform/**
  - リソースごとのtfファイル
- **images/**
  - 構成図など
- **lambda_layer/**
  - AWS Lambda関数およびレイヤのためのDocker Imageを作成する
- **lambda_layer/build.bat**
  - AWS Lambda関数およびレイヤのための環境を作成する
-  **lambda_layer/debug_atach.bat**
  - 上記デバッグ用
  

# 動作方法
deploy.bat、withdraw.batが存在するディレクトリに移動してください
- 開始:
  deploy.batを実行する。
- 終了:
  withdraw.batを実行する。
