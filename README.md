# Ahan-Whun-Sgoi

## Usage

こんな感じで利用できます。

```lisp
;; コマンドの一覧を表示
(aws :help)

;; コマンド:ec2 のサブコマンドの一覧を表示
(aws :ec2 :help)

;; サブコマンド:describe-instances のオプションの一覧を表示
(aws :ec2 :describe-instances :help)

;; サブコマンド:describe-instances を実行
(aws :ec2 :describe-instances :--profile "your profile name")
```

## Installation

プログラムをロードする。

```lisp
(ql:quickload :ahan-whun-shugoi)
```

## Settings

DBを起動する。

```lisp
(aws.db:start)
```

WEBからDBにデータを取り込む。(1〜2時間くらい)

```lisp
(defvar *collect*
  (bordeaux-threads:make-thread
   #'(lambda ()
       (time (collect)))))
```

## Requirement

- [cl-ppcre](https://edicl.github.io/cl-ppcre/)
- [local-time](https://github.com/dlowe-net/local-time)
- [trivial-shell](https://github.com/gwkkwg/trivial-shell)
- [split-sequence](https://github.com/sharplispers/split-sequence)
- [closure-html](https://common-lisp.net/project/closure/closure-html/)
- [jonathan](https://github.com/Rudolph-Miller/jonathan)
- [quri](https://github.com/fukamachi/quri)
- [dexador](https://github.com/fukamachi/dexador)
- [lparallel](https://github.com/lmj/lparallel)
- [shinrabanshou](https://github.com/yanqirenshi/shinrabanshou)

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the MIT License.
