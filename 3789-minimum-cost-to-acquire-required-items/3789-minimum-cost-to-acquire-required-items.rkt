#|
Brute Force

(define/contract (minimum-cost cost1 cost2 costBoth need1 need2)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? exact-integer? exact-integer?)
  (for/fold ([best (+ (* need1 cost1) (* need2 cost2))]) ([k (in-range (add1 (max need1 need2)))])
    (min best (+ (* k costBoth) (* (max 0 (- need1 k)) cost1) (* (max 0 (- need2 k)) cost2)))))
|#

#|
Better Approach

(define/contract (minimum-cost cost1 cost2 costBoth need1 need2)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? exact-integer? exact-integer?)
  (define (total k)
    (+ (* k costBoth) (* (max 0 (- need1 k)) cost1) (* (max 0 (- need2 k)) cost2)))
  (let loop ([lo 0] [hi (max need1 need2)])
    (if (>= lo hi)
        (total lo)
        (let ([mid (quotient (+ lo hi) 2)])
          (if (<= (total mid) (total (add1 mid)))
              (loop lo mid)
              (loop (add1 mid) hi))))))
|#

(define/contract (minimum-cost cost1 cost2 costBoth need1 need2)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? exact-integer? exact-integer?)
  (define both (min need1 need2))
  (+ (* both (min costBoth (+ cost1 cost2)))
     (* (- need1 both) (min cost1 costBoth))
     (* (- need2 both) (min cost2 costBoth))))