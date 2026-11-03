#|
Brute Force

(define/contract (min-operations nums x k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define arr (list->vector nums))
  (define n (vector-length arr))
  (define (window-cost i)
    (define w (sort (for/list ([t (in-range i (+ i x))]) (vector-ref arr t)) <))
    (define med (list-ref w (quotient x 2)))
    (for/sum ([v w]) (abs (- v med))))
  (define (dfs i j)
    (cond
      [(= j 0) 0]
      [(< (- n i) (* j x)) +inf.0]
      [else (min (dfs (add1 i) j) (+ (window-cost i) (dfs (+ i x) (sub1 j))))]))
  (inexact->exact (dfs 0 k)))
|#

#|
Better Approach

(define/contract (min-operations nums x k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define arr (list->vector nums))
  (define n (vector-length arr))
  (define cost
    (for/vector ([i (in-range (add1 (- n x)))])
      (define w (sort (for/list ([t (in-range i (+ i x))]) (vector-ref arr t)) <))
      (define med (list-ref w (quotient x 2)))
      (for/sum ([v w]) (abs (- v med)))))
  (define inf (expt 2 62))
  (define prev
    (for/fold ([prev (make-vector (add1 n) 0)]) ([j (in-range k)])
      (define cur (make-vector (add1 n) inf))
      (for ([i (in-range x (add1 n))])
        (vector-set! cur i (min (vector-ref cur (sub1 i))
                                (+ (vector-ref prev (- i x)) (vector-ref cost (- i x))))))
      cur))
  (vector-ref prev n))
|#

(define/contract (min-operations nums x k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define arr (list->vector nums))
  (define n (vector-length arr))
  (define vals (list->vector (sort (remove-duplicates nums) <)))
  (define m (vector-length vals))
  (define pos (make-hash))
  (for ([v vals] [i (in-naturals 1)]) (hash-set! pos v i))
  (define idx (for/vector ([v arr]) (hash-ref pos v)))
  (define top (let loop ([t 1]) (if (<= (* t 2) m) (loop (* t 2)) t)))
  (define cnt (make-vector (add1 m) 0))
  (define sum (make-vector (add1 m) 0))
  (define cost (make-vector (add1 (- n x)) 0))
  (define half (quotient (add1 x) 2))
  (define (update! i d)
    (let loop ([p (vector-ref idx i)])
      (when (<= p m)
        (vector-set! cnt p (+ (vector-ref cnt p) d))
        (vector-set! sum p (+ (vector-ref sum p) (* d (vector-ref arr i))))
        (loop (+ p (bitwise-and p (- p)))))))
  (for/fold ([total 0]) ([i (in-range n)])
    (update! i 1)
    (define t1
      (if (>= i x)
          (begin (update! (- i x) -1) (- (+ total (vector-ref arr i)) (vector-ref arr (- i x))))
          (+ total (vector-ref arr i))))
    (when (>= i (sub1 x))
      (define-values (p low-cnt low-sum)
        (let loop ([step top] [p 0] [need half] [low-cnt 0] [low-sum 0])
          (cond
            [(= step 0) (values p low-cnt low-sum)]
            [(and (<= (+ p step) m) (< (vector-ref cnt (+ p step)) need))
             (define q (+ p step))
             (define c (vector-ref cnt q))
             (loop (quotient step 2) q (- need c) (+ low-cnt c) (+ low-sum (vector-ref sum q)))]
            [else (loop (quotient step 2) p need low-cnt low-sum)])))
      (define med (vector-ref vals p))
      (vector-set! cost (add1 (- i x))
                   (+ (- (* med low-cnt) low-sum) (- t1 low-sum) (- (* med (- x low-cnt))))))
    t1)
  (define inf (expt 2 62))
  (define prev
    (for/fold ([prev (make-vector (add1 n) 0)]) ([j (in-range k)])
      (define cur (make-vector (add1 n) inf))
      (for ([i (in-range x (add1 n))])
        (vector-set! cur i (min (vector-ref cur (sub1 i))
                                (+ (vector-ref prev (- i x)) (vector-ref cost (- i x))))))
      cur))
  (vector-ref prev n))