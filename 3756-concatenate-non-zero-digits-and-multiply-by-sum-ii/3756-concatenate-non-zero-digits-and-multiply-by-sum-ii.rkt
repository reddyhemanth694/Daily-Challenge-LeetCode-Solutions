#|
Brute Force

(define/contract (sum-and-multiply s queries)
  (-> string? (listof (listof exact-integer?)) (listof exact-integer?))
  (define mod 1000000007)
  (for/list ([q queries])
    (define-values (x sum)
      (for/fold ([x 0] [sum 0]) ([i (in-range (first q) (add1 (second q)))])
        (define d (- (char->integer (string-ref s i)) 48))
        (if (zero? d)
            (values x sum)
            (values (modulo (+ (* x 10) d) mod) (+ sum d)))))
    (modulo (* x sum) mod)))
|#

#|
Better Approach

(define/contract (sum-and-multiply s queries)
  (-> string? (listof (listof exact-integer?)) (listof exact-integer?))
  (define mod 1000000007)
  (define (power b e)
    (cond
      [(zero? e) 1]
      [(even? e) (power (modulo (* b b) mod) (quotient e 2))]
      [else (modulo (* b (power b (sub1 e))) mod)]))
  (define m (string-length s))
  (define pre (make-vector (add1 m) 0))
  (define cnt (make-vector (add1 m) 0))
  (define sum (make-vector (add1 m) 0))
  (for ([i (in-range m)])
    (define d (- (char->integer (string-ref s i)) 48))
    (vector-set! pre (add1 i) (if (zero? d) (vector-ref pre i) (modulo (+ (* (vector-ref pre i) 10) d) mod)))
    (vector-set! cnt (add1 i) (+ (vector-ref cnt i) (if (zero? d) 0 1)))
    (vector-set! sum (add1 i) (+ (vector-ref sum i) d)))
  (for/list ([q queries])
    (define l (first q))
    (define r (add1 (second q)))
    (define k (- (vector-ref cnt r) (vector-ref cnt l)))
    (define x (modulo (- (vector-ref pre r) (* (vector-ref pre l) (power 10 k))) mod))
    (modulo (* x (- (vector-ref sum r) (vector-ref sum l))) mod)))
|#

(define/contract (sum-and-multiply s queries)
  (-> string? (listof (listof exact-integer?)) (listof exact-integer?))
  (define mod 1000000007)
  (define m (string-length s))
  (define pre (make-vector (add1 m) 0))
  (define pw (make-vector (add1 m) 1))
  (define cnt (make-vector (add1 m) 0))
  (define sum (make-vector (add1 m) 0))
  (for ([i (in-range m)])
    (define d (- (char->integer (string-ref s i)) 48))
    (vector-set! pw (add1 i) (modulo (* (vector-ref pw i) 10) mod))
    (vector-set! pre (add1 i) (if (zero? d) (vector-ref pre i) (modulo (+ (* (vector-ref pre i) 10) d) mod)))
    (vector-set! cnt (add1 i) (+ (vector-ref cnt i) (if (zero? d) 0 1)))
    (vector-set! sum (add1 i) (+ (vector-ref sum i) d)))
  (for/list ([q queries])
    (define l (first q))
    (define r (add1 (second q)))
    (define k (- (vector-ref cnt r) (vector-ref cnt l)))
    (define x (modulo (- (vector-ref pre r) (* (vector-ref pre l) (vector-ref pw k))) mod))
    (modulo (* x (- (vector-ref sum r) (vector-ref sum l))) mod)))