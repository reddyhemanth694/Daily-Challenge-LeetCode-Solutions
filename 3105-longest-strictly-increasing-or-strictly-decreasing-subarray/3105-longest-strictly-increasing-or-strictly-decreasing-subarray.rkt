#|
Brute Force

(define/contract (longest-monotonic-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (define v (list->vector nums))
  (define n (vector-length v))
  (define (run i cmp)
    (let loop ([j (add1 i)] [len 1])
      (if (and (< j n) (cmp (vector-ref v j) (vector-ref v (sub1 j))))
          (loop (add1 j) (add1 len))
          len)))
  (for/fold ([res 1]) ([i (in-range n)])
    (max res (run i >) (run i <))))
|#

#|
Better Approach

(define/contract (longest-monotonic-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (pass cmp)
    (for/fold ([res 1] [len 1] [prev (car nums)] #:result res) ([x (cdr nums)])
      (define l (if (cmp x prev) (add1 len) 1))
      (values (max res l) l x)))
  (max (pass >) (pass <)))
|#

(define/contract (longest-monotonic-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (for/fold ([res 1] [inc 1] [dec 1] [prev (car nums)] #:result res) ([x (cdr nums)])
    (define i (if (> x prev) (add1 inc) 1))
    (define d (if (< x prev) (add1 dec) 1))
    (values (max res i d) i d x)))