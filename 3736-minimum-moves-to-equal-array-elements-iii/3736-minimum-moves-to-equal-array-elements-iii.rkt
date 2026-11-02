#|
Brute Force

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (bump lst mn)
    (if (= (car lst) mn)
        (cons (add1 mn) (cdr lst))
        (cons (car lst) (bump (cdr lst) mn))))
  (let loop ([nums nums] [moves 0])
    (define mn (apply min nums))
    (if (= (apply max nums) mn)
        moves
        (loop (bump nums mn) (add1 moves)))))
|#

#|
Better Approach

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define sorted (sort nums <))
  (define last-value (last sorted))
  (for/sum ([x sorted]) (- last-value x)))
|#

(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (define-values (mx sum n)
    (for/fold ([mx 0] [sum 0] [n 0]) ([x nums])
      (values (max mx x) (+ sum x) (add1 n))))
  (- (* mx n) sum))