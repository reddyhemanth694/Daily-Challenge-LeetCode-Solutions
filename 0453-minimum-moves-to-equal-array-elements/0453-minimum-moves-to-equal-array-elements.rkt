#|
Brute Force

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (bump lst mx)
    (if (= (car lst) mx)
        (cons mx (map add1 (cdr lst)))
        (cons (add1 (car lst)) (bump (cdr lst) mx))))
  (let loop ([nums nums] [moves 0])
    (define mx (apply max nums))
    (if (= (apply min nums) mx)
        moves
        (loop (bump nums mx) (add1 moves)))))
|#

#|
Better Approach

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define sorted (sort nums <))
  (for/sum ([x sorted]) (- x (car sorted))))
|#

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define mn (for/fold ([m (car nums)]) ([x nums]) (min m x)))
  (for/sum ([x nums]) (- x mn)))