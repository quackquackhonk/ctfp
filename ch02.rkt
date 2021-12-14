#lang racket

(require rackunit)
(require "ch01.rkt")

;; memoizes the given function using an association list
;; memoize : (A -> B) -> (A -> B)
(define (memoize f)
  (define memo (make-hash '()))
  (lambda (x)
    (if (hash-has-key? memo x) 
        (hash-ref memo x)
        (let ([val (f x)])
          (hash-set! memo x val)
          val))))

;; factorial function used for testing
(define (fact n)
  (if (= n 0) 1 (* n (fact (sub1 n)))))

(test-case
  "memoize fact"
  (define fact-start (current-seconds))
  (define big-num (+ (fact 40000) (fact 40000)))
  (define total-fact (- (current-seconds) fact-start))
  (define fact-memo (memoize fact))
  (define memo-fact-start (current-seconds))
  (define fast-big-num (+ (fact-memo 40000) (fact-memo 40000)))
  (define total-fact-memo (- (current-seconds) memo-fact-start))
  (check-equal? fast-big-num big-num)
  (check-equal? (< total-fact-memo total-fact) #t))

;; we can memoize our randomness function!
;; it doesn't make it random anymore, though
(test-case
  "memoize random"
  (define memo-random (memoize random))
  (check-equal? (memo-random 100) (memo-random 100))
  (check-equal? (memo-random 12) (memo-random 12)))

(define (first-seed-random ss)
  (random-seed ss)
  (random))
(test-case
  "memoize seeded random"
  (define memo-seed-random (memoize first-seed-random))
  (check-equal? (memo-seed-random 100) (memo-seed-random 100))
  (check-equal? (memo-seed-random 12) (memo-seed-random 12)))

#|
4. A and D are pure functions, since B reads a character, and C prints a line to stdout.

5. There's 4?
|#
;; All bools go to #t
(define/contract (always-#t bb)
  (-> boolean? boolean)
  #t)
;; all bools go to #f
(define/contract (always-#f bb)
  (-> boolean? boolean)
  #f)
;; all bools go to themselvs
(define/contract (same-bool bb)
  (-> boolean? boolean)
  (id bb))
;; all bools go to the negation of themselves
(define/contract (neg-bool bb)
  (-> boolean? boolean)
  (not bb))

#|

  Void-----absurd------>()< id
    |                    |
    | absurd             |
    V                    |
  Bool<------------------|
  ^ id

|#