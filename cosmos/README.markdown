# Ahan-Whun-Shugoi.Cosmos

## Usage

## Installation

## 設計

のための考察

### json レスポンスのトップレベルは以下の二つの要素で考える。

- envelope
- contents

エンベロープはサブコマンド毎に設定が必要。

### サブコマンドとエンティティは別である。

そうした場合エンティティは独自に設計する必要がある。

というかどこかに落ちていないのか。

もしくは最大公約数的に Class に実装していくべきなのか。

describe-network-interfaces で考えてみる

以下のような Relashonship が考えられる。

```lisp
 (:NetworkInterfaces :|Association| :Association)
```

これをもう一段抽象化すると、以下のようになる。

```lisp
 (:NetworkInterfaces :Association)
```

ふむ。。。

以下のアルゴリズムで実装すれば良さそう。

1. plist がきました。
2. root の要素を舐めて Entity の Attributes を構成します。
3. 特定のキーワード(ex :|Association|) があります
   1. これはリレーションと判断します。
   2. これにリレーション先の Entitiy を特定します。
   3. Entitiy がなければ作成します。
   4. Entitiy とのリレーションがなければ作成します。

しかし、以下のような構成の場合シンプルには行かない。
これがどういう構成なのか理解する必要がある。

```lisp
(defvar *sample-ec2_describe-network-interfaces*
  '(:|NetworkInterfaces|
      :|PrivateIpAddresses| ((:|Association| (:|IpOwnerId| ""
                                              :|AllocationId| ""
                                              :|PublicDnsName| ""
                                              :|AssociationId| ""
                                              :|PublicIp| "")
                              :|Primary| T
                              :|PrivateIpAddress| ""))))))
```

### Entity を定義すべきだな。
