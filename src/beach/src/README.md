# SRC/BEACH/

## Description

AWS Cli のサイトから コマンド、サブコマンド、オプションを収集しDBに保管する。

そのDBの内容を aws パッケージが利用する。

## Usage

```
(under-the-paving-stone-the-beach :target :logs :refresh t)
```

## Function `under-the-paving-stone-the-beach`

### Syntax

__under-the-paving-stone-the-beach__ &key _target_ _uri_ _refresh_ ⇒ nil

### Arguments and Values

| Name    | Description                                                               | 初期値                                                      |
|---------|---------------------------------------------------------------------------|-------------------------------------------------------------|
| target  | 収集する対象のコマンドを指定する。:all の場合全てのコマンドを対象とする。 | :all                                                        |
| uri     | 収集を開始する URL を指定する。                                           | https://docs.aws.amazon.com/cli/latest/reference/index.html |
| refresh | DBの内容を収集前に全てクリア(削除)するかどうかを指定する。                | nil                                                         |

### Description

AWS Cli のサイトから コマンド、サブコマンド、オプションを収集する。
