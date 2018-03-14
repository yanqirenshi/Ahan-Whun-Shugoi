# Ahan-Whun-Sgoi

## Usage

> **aws** _command_ &rest _options_ => _list_

## EC2

```lisp
(aws :ec2 :describe-instances :--profile "")
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
