(define/contract (find-min-arrow-shots points)
  (-> (listof (listof exact-integer?)) exact-integer?)

  (define sorted-points
    (sort points < #:key second))

  (define result
    (for/fold ([state (cons 1 (second (first sorted-points)))])
              ([point (in-list (rest sorted-points))])

      (define arrows (car state))
      (define arrow (cdr state))

      (if (> (first point) arrow)
          (cons (+ arrows 1) (second point))
          state)))

  (car result)
)