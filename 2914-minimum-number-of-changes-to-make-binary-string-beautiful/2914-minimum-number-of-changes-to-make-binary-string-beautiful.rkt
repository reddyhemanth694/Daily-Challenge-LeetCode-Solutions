#|
Brute Force

(define/contract (min-changes s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define (solve i)
    (if (= i n)
        0
        (for/fold ([best n] [ones 0] #:result best) ([j (in-range i n)])
          (define o (if (char=? (string-ref s j) #\1) (add1 ones) ones))
          (define len (- j i -1))
          (values (if (even? len) (min best (+ (min o (- len o)) (solve (add1 j)))) best) o))))
  (solve 0))
|#

#|
Better Approach

(define/contract (min-changes s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define dp (make-vector (add1 n) n))
  (vector-set! dp 0 0)
  (for ([i (in-range 0 n 2)])
    (for/fold ([ones 0]) ([j (in-range i n)])
      (define o (if (char=? (string-ref s j) #\1) (add1 ones) ones))
      (define len (- j i -1))
      (when (even? len)
        (vector-set! dp (add1 j) (min (vector-ref dp (add1 j)) (+ (vector-ref dp i) (min o (- len o))))))
      o))
  (vector-ref dp n))
|#

(define/contract (min-changes s)
  (-> string? exact-integer?)
  (for/sum ([i (in-range 0 (string-length s) 2)])
    (if (char=? (string-ref s i) (string-ref s (add1 i))) 0 1)))