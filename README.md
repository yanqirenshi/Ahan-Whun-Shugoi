# Ahan-Whun-Sgoi

## Usage

> **aws** _command_ &rest _options_ => _list_

## EC2

```lisp
(aws :ec2 :describe-instances :--profile "")
```

## Scraping

WEB(html) ⇒ DB(Shinrabanshou)

```lisp
(collect :uri "https://docs.aws.amazon.com/cli/latest/reference/")
```


## Installation

プログラムをロードする。

```lisp
(ql:quickload :ahan-whun-shugoi)
```

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

## Author

* Satoshi Iwasaki (yanqirenshi@gmail.com)

## Copyright

Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)

## License

Licensed under the MIT License.
