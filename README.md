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

- cl-ppcre
- local-time
- trivial-shell
- split-sequence
- jonathan
- closure-html
- quri
- dexador
- lparallel
- upanishad
- shinrabanshou

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the MIT License.
