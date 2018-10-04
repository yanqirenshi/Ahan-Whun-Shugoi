# SRC/CMD-BUILDER/

## Description

AWS Cli のコマンドを生成します。

## Usage

`aws.cli.command:make-aws-cli-command` をコールする感じです。

## Packages

| Name                         | Nickname        |
|------------------------------|-----------------|
| ahan-whun-shugoi.cli.command | aws.cli.command |
| ahan-whun-shugoi.cli.config  | aws.cli.config  |
| ahan-whun-shugoi.cli.option  | aws.cli.option  |

## Option の値の個数チェック

Option の値の個数をチェックします。

2018-04-16 (Mon) 時点では未実装です。

## Option の値の型チェック

Option の値の型チェックは実施したいと考えています。

2018-04-16 (Mon) 時点では未実装です。

### Value type of Options

value type は以下 9 種類の様です。

| type      | description |
|-----------|-------------|
| long      |             |
| integer   |             |
| timestamp |             |
| map       |             |
| boolean   |             |
| blob      |             |
| structure |             |
| list      |             |
| string    |             |
