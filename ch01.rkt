#lang racket

;; the identity morphism
;; id : 
(define (id xx) xx)

(define (compose f g) (lambda (x) (f (g x))))