#|
Brute Force

(define/contract (sum-and-multiply n)
  (-> exact-integer? exact-integer?)
  (define t (string-replace (number->string n) "0" ""))
  (if (string=? t "")
      0
      (* (string->number t)
         (for/sum ([c t]) (- (char->integer c) 48)))))
|#

#|
Better Approach

(define/contract (sum-and-multiply n)
  (-> exact-integer? exact-integer?)
  (define digits
    (let loop ([n n] [acc '()])
      (if (zero? n) acc (loop (quotient n 10) (cons (remainder n 10) acc)))))
  (define-values (x sum)
    (for/fold ([x 0] [sum 0]) ([d digits])
      (if (zero? d) (values x sum) (values (+ (* x 10) d) (+ sum d)))))
  (* x sum))
|#

(define/contract (sum-and-multiply n)
  (-> exact-integer? exact-integer?)
  (let loop ([n n] [x 0] [sum 0] [p 1])
    (cond
      [(zero? n) (* x sum)]
      [(zero? (remainder n 10)) (loop (quotient n 10) x sum p)]
      [else
       (define d (remainder n 10))
       (loop (quotient n 10) (+ x (* d p)) (+ sum d) (* p 10))])))