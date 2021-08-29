(test-group "== Relations"

  (test "Unification of basic variable"
        (run 1 (q) (== 5 q))
        (list 5))

  (test "Unification of multiple fresh variables"
        (run* (q)
          (fresh (a d)
            (conde
              ((== 5 a))
              ((== 6 d)))
            (== `(,a . ,d) q)))
        `((5 . _.0) (_.0 . 6)))

  (test "Appending two lists"
        (run* (q) (appendo '(a b c) '(d e) q))
        '((a b c d e)))

  (test "Appending a variable and a list to a known list"
        (run* (q) (appendo q '(d e) '(a b c d e)))
        '((a b c)))

  (test "Appending a list and a variable to a known list"
        (run* (q) (appendo '(a b c) q '(a b c d e)))
        '((d e)))

  (test "Appending two fresh lists"
        (run 5 (q)
          (fresh (l s out)
            (appendo l s out)
            (== `(,l ,s ,out) q)))
        '((() _.0 _.0)
          ((_.0) _.1 (_.0 . _.1))
          ((_.0 _.1) _.2 (_.0 _.1 . _.2))
          ((_.0 _.1 _.2) _.3 (_.0 _.1 _.2 . _.3))
          ((_.0 _.1 _.2 _.3) _.4 (_.0 _.1 _.2 _.3 . _.4))))
  )
