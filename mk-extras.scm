;;; The MIT License (MIT)
;;;
;;; Copyright (c) 2016 Alex Shinn, Jeremy Steward
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

;;; Code that accompanies ``The Reasoned Schemer''
;;; Daniel P. Friedman, William E. Byrd and Oleg Kiselyov
;;; MIT Press, Cambridge, MA, 2005
;;;
;;; Mostly complete implementation of the logic system used in the book,
;;; adapted to CHICKEN Scheme by Alex Shinn.

;;; Originally Adapted for Chicken by Alex Shinn 2005-11-02 10:14:45
;;; Adapted to latest miniKanren by Jeremy Steward 2012-02-05
;;;
;;; Some differences of note:
;;; - No eqo or eq-caro, as these correspond to == and caro respectively
;;; - Else clauses have been removed, as well as extraneous succeeds or fails
;;; - Lambda-style definitions were converted to the simplified define forms

(define charo (make-tag-A 'char char?))
(define atomo (make-tag-A 'atom atom?))

(define (caro p a)
  (fresh (d)
    (== (cons a d) p)))

(define (cdro p d)
  (fresh (a)
    (== (cons a d) p)))

(define (conso a d p)
  (== (cons a d) p))

(define (nullo x)
  (== '() x))

(define (pairo p)
  (fresh (a d)
    (conso a d p)))

(define (listo l)
  (conde
    ((nullo l))
    ((pairo l)
     (fresh (d)
       (cdro l d)
       (listo d)))))

(define (membero x l)
  (conde
    ((nullo l) fail)
    ((caro l x))
    ((fresh (d)
       (cdro l d)
       (membero x d)))))

(define (rembero x l out)
  (conde
    ((nullo l) (nullo out))
    ((caro l x) (cdro l out))
    ((fresh (a d res)
       (conso a d l)
       (=/= a x)
       (conso a res out)
       (rembero x d res)))))

(define (appendo l s out)
  (conde
    ((nullo l) (== s out))
    ((fresh (a d res)
       (conso a d l)
       (conso a res out)
       (appendo d s res)))))

(define (flatteno s out)
  (conde
    ((nullo s) (nullo out))
    ((pairo s)
     (fresh (a d res-a res-d)
       (conso a d s)
       (flatteno a res-a)
       (flatteno d res-d)
       (appendo res-a res-d out)))
    ((atomo s) (conso s '() out))))

(define (lengtho xs k)
  (conde
   ((nullo xs) (nullo k))
   ((fresh (a d k0)
      (conso a d xs)
      (-o k (build-num 1) k0)
      (lengtho d k0)))))

(define (anyo g)
  (conde
    (g)
    ((anyo g))))

(define nevero (anyo fail))

;; Defined this way as per William Byrd's thesis (Ch. 5, example 3)
;; because of tabling issues.
(define alwayso
  (letrec ((alwayso (lambda ()
                      (conde
                        ((== #f #f))
                        ((alwayso))))))
    (alwayso)))

(define (everyo g lst)
  (conde
   ((nullo lst))
   ((fresh (a d)
      (conso a d lst)
      (g a)
      (everyo g d)))))

;; A relation which guarantees no element of s will unify with another element
;; of s.
(define (distincto s)
  (conde
    ((nullo s))
    ((fresh (a d)
       (conso a d s)
       (nullo d)
       (=/= a d)))
    ((fresh (h0 h1 t)
       (== `(,h0 ,h1 . ,t) s)
       (=/= h0 h1)
       (distincto `(,h0 . ,t))
       (distincto `(,h1 . ,t))))))

;; A relation that will permute xl into the yl. May not terminate if xl is not
;; ground.
;;
;; Adapted from the definition in Clojure's core.logic, LICENSE can be found at:
;; https://github.com/clojure/core.logic/blob/master/LICENSE
(define (permuteo xl yl)
  (conde
    ((nullo xl)
     (nullo yl))
    ((fresh (x xs ys)
       (conso x xs xl)
       (permuteo xs ys)
       (rembero x yl ys)))))
