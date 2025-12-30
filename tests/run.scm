(cond-expand
  ((or chicken-5 chicken-6)
   (import test mini-kanren))
  (chicken-4
    (use test mini-kanren))
  (else))

(test-group "miniKanren"
  (include "==-tests.scm")
  (include "symbolo-tests.scm")
  (include "numbero-tests.scm")
  (include "symbolo-numbero-tests.scm")
  (include "disequality-tests.scm")
  (include "absento-closure-tests.scm")
  (include "absento-tests.scm")
  (include "numbers-tests.scm")
  )

(test-exit)
