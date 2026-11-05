#|
Brute Force

(define/contract (find-the-distance-value arr1 arr2 d)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (for/sum ([a arr1])
    (if (for/and ([b arr2]) (> (abs (- a b)) d)) 1 0)))
|#

#|
Better Approach

(define/contract (find-the-distance-value arr1 arr2 d)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (define v (list->vector (sort arr2 <)))
  (define m (vector-length v))
  (define (lower-bound x)
    (let loop ([lo 0] [hi m])
      (if (>= lo hi)
          lo
          (let ([mid (quotient (+ lo hi) 2)])
            (if (< (vector-ref v mid) x) (loop (add1 mid) hi) (loop lo mid))))))
  (for/sum ([a arr1])
    (define i (lower-bound (- a d)))
    (if (or (= i m) (> (vector-ref v i) (+ a d))) 1 0)))
|#

(define/contract (find-the-distance-value arr1 arr2 d)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (define pre (make-vector 2202 0))
  (for ([v arr2])
    (vector-set! pre (+ v 1101) (add1 (vector-ref pre (+ v 1101)))))
  (for ([i (in-range 1 2202)])
    (vector-set! pre i (+ (vector-ref pre i) (vector-ref pre (sub1 i)))))
  (for/sum ([a arr1])
    (if (= (vector-ref pre (+ a d 1101)) (vector-ref pre (+ (- a d) 1100))) 1 0)))