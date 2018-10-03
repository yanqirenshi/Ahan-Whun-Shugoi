# Ahan-Whun-Sgoi

おおまかに以下のような機能で構成されます。

| Dir     | Description                                                       |
|---------|-------------------------------------------------------------------|
| beach/  | [AWS Cli のマニュアル]() をローカルのDBに取り込む。               |
| core/   | `beach/` で取り込んだ情報を元に AWS Cli のコマンド作成&実行する。 |
| api/    | `web/` 用のREST-API。                                             |
| web/    | `beach/`, `core/` の情報をWEBブラウザでビジュアルアイズする。     |

## Usage/Installation

```
(ql:quickload :ahan-whun-shugoi-beach)
(ql:quickload :ahan-whun-shugoi)
(ql:quickload :ahan-whun-shugoi-api)

(aws.beach.db:start)
(aws.db:start)
```


詳細の利用方法は各ディレクトリの README 参照。

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the MIT License.
