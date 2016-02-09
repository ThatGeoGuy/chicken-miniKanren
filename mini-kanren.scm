;;; The MIT License (MIT)
;;;
;;; Copyright (c) 2014 Daniel P. Friedman, Oleg Kiselyov, and William E. Byrd
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a copy
;;; of this software and associated documentation files (the "Software"), to deal
;;; in the Software without restriction, including without limitation the rights
;;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;;; copies of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in all
;;; copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;;; SOFTWARE.
;;;
;;; Taken from https://github.com/miniKanren/miniKanren and modified to work
;;; with CHICKEN Scheme by Jeremy Steward on 2016-02-05

(module mini-kanren *
  (import chicken scheme)
  (use data-structures
       extras
       (only ports call-with-output-string)
       (only srfi-1 remove any))

  (define remp remove)
  (define exists any)
  (define call-with-string-output-port call-with-output-string)

  (include "mk.scm")
  (include "mk-extras.scm"))
