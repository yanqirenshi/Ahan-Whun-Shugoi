(in-package :ahan-whun-shugoi)

(defun cmds-s3 ()
  '((:cp (:--dryrun
          :--quiet
          :--include
          :--exclude
          :--acl
          :--follow-symlinks
          :--no-follow-symlinks
          :--no-guess-mime-type
          :--sse
          :--storage-class
          :--grants
          :--website-redirect
          :--content-type
          :--cache-control
          :--content-disposition
          :--content-encoding
          :--content-language
          :--expires
          :--source-region
          :--only-show-errors
          :--page-size
          :--metadata-directive
          :--expected-size
          :--recursive))
    (:ls (:--recursive :--page-size :--human-readable :--summarize)
     (:mb)
     (:mv (:--dryrun
           :--quiet
           :--include
           :--exclude
           :--acl
           :--follow-symlinks
           :--no-follow-symlinks
           :--no-guess-mime-type
           :--sse
           :--storage-class
           :--grants
           :--website-redirect
           :--content-type
           :--cache-control
           :--content-disposition
           :--content-encoding
           :--content-language
           :--expires
           :--source-region
           :--only-show-errors
           :--page-size
           :--metadata-directive
           :--recursive)
      (:rb (:--force)
       :rm (:--dryrun
            :--quiet
            :--recursive
            :--include
            :--exclude
            :--only-show-errors
            :--page-size)
       (:sync (:--dryrun
               :--quiet
               :--include
               :--exclude
               :--acl
               :--follow-symlinks
               :--no-follow-symlinks
               :--no-guess-mime-type
               :--sse
               :--storage-class
               :--grants
               :--website-redirect
               :--content-type
               :--cache-control
               :--content-disposition
               :--content-encoding
               :--content-language
               :--expires
               :--source-region
               :--only-show-errors
               :--page-size
               :--size-only
               :--exact-timestamps
               :--delete)
        (:website (:--index-document
                   :--error-document))))))))
