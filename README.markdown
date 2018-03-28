# Ahan-Whun-Sgoi

おおまかに以下のような機能で構成されます。

| Dir     | Description                                                       |
|---------|-------------------------------------------------------------------|
| beach/  | [AWS Cli のマニュアル]() をローカルのDBに取り込む。               |
| core/   | `beach/` で取り込んだ情報を元に AWS Cli のコマンド作成&実行する。 |
| cosmos/ | `core/` での実行結果をローカルDBに保存する。                      |
| api/    | `web/` 用のREST-API。                                             |
| web/    | `beach/`, `core/` の情報をWEBブラウザでビジュアルアイズする。     |

## Usage/Installation

詳細の利用方法は各ディレクトリの README 参照。

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the MIT License.
