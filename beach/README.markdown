# Ahan-Whun-Shugoi-Beach

## Usage

DBを起動する。

```lisp
(aws-beach.db:start)
```

WEBからDBにデータを取り込む。(1〜2時間くらい)

```lisp
(defvar *collect*
  (bordeaux-threads:make-thread
   #'(lambda ()
       (time (collect)))))
```

## Installation
