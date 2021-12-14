#lang racket

(require rackunit)
(provide id compose)

;; the identity morphism
(define (id x) x)
;; tests
(check-equal? (id 10) 10)
(check-equal? (id id) id)
(check-equal? (id '(1 2 3)) '(1 2 3))

;; composes two functions f and g
;; (compose f g) is f . g
(define (compose f g) (lambda (x) (f (g x))))
;; tests (or attempts to test)
(check-equal? ((compose add1 id) 1) 2)
(check-equal? ((compose id add1) 1) 2)
 
#|
4. Not all websites have links to themselves, and links don't necessarily compose.

5. Friendship is not a morphism, since friendships don't compose. The friend of my friend isn't
always my friend (on Facebook)

6. When all nodes have edges that go to themselves, directed graphs are categories.
|#