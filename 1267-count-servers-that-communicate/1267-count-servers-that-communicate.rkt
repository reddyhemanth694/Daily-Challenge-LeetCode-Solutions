#|
Brute Force
(define/contract (count-servers grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define m (length grid))
  (define n (length (car grid)))
  (define (at i j) (list-ref (list-ref grid i) j))
  (for*/sum ([i (in-range m)] [j (in-range n)])
    (if (and (= (at i j) 1)
             (or (for/or ([k (in-range n)]) (and (not (= k j)) (= (at i k) 1)))
                 (for/or ([k (in-range m)]) (and (not (= k i)) (= (at k j) 1)))))
        1
        0)))
|#

#|
Better Approach
(define/contract (count-servers grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define rows (map (lambda (r) (apply + r)) grid))
  (define cols (apply map + grid))
  (for/sum ([row grid] [rs rows])
    (for/sum ([v row] [cs cols])
      (if (and (= v 1) (or (> rs 1) (> cs 1))) 1 0))))
|#

; Optimized Approach: answer = total - isolated (isolated = alone in row and column)
(define/contract (count-servers grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define rows (map (lambda (r) (apply + r)) grid))
  (define cols (apply map + grid))
  (define isolated
    (for/sum ([row grid] [rs rows])
      (if (= rs 1)
          (for/sum ([v row] [cs cols])
            (if (and (= v 1) (= cs 1)) 1 0))
          0)))
  (- (apply + rows) isolated))