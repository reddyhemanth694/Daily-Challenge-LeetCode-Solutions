#|
Brute Force

(define/contract (num-of-subarrays arr)
  (-> (listof exact-integer?) exact-integer?)
  (define v (list->vector arr))
  (define n (vector-length v))
  (modulo
   (for*/sum ([i (in-range n)]
              [j (in-range i n)]
              #:when (odd? (for/sum ([k (in-range i (add1 j))]) (vector-ref v k))))
     1)
   1000000007))
|#

#|
Better Approach

(define/contract (num-of-subarrays arr)
  (-> (listof exact-integer?) exact-integer?)
  (define v (list->vector arr))
  (define n (vector-length v))
  (modulo
   (for/sum ([i (in-range n)])
     (for/fold ([sum 0] [cnt 0] #:result cnt) ([j (in-range i n)])
       (define s (+ sum (vector-ref v j)))
       (values s (if (odd? s) (add1 cnt) cnt))))
   1000000007))
|#

(define/contract (num-of-subarrays arr)
  (-> (listof exact-integer?) exact-integer?)
  (for/fold ([odd 0] [even 1] [sum 0] [ans 0] #:result ans) ([x (in-list arr)])
    (define s (+ sum x))
    (if (odd? s)
        (values (add1 odd) even s (modulo (+ ans even) 1000000007))
        (values odd (add1 even) s (modulo (+ ans odd) 1000000007)))))