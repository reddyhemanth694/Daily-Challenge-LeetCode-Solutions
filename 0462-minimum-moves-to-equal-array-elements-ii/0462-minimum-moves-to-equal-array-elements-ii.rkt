#|
Brute Force

(define/contract (min-moves2 nums)
  (-> (listof exact-integer?) exact-integer?)
  (apply min (for/list ([x nums]) (for/sum ([a nums]) (abs (- a x))))))
|#

#|
Better Approach

(define/contract (min-moves2 nums)
  (-> (listof exact-integer?) exact-integer?)
  (define median (list-ref (sort nums <) (quotient (length nums) 2)))
  (for/sum ([a nums]) (abs (- a median))))
|#

(define/contract (min-moves2 nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (select lst k)
    (define pivot (list-ref lst (random (length lst))))
    (define less (filter (lambda (x) (< x pivot)) lst))
    (define greater (filter (lambda (x) (> x pivot)) lst))
    (define equal (- (length lst) (length less) (length greater)))
    (cond
      [(< k (length less)) (select less k)]
      [(< k (+ (length less) equal)) pivot]
      [else (select greater (- k (length less) equal))]))
  (define median (select nums (quotient (length nums) 2)))
  (for/sum ([a nums]) (abs (- a median))))