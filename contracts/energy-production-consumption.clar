;; Energy Production and Consumption Contract

(define-map energy-data
  { user: principal, timestamp: uint }
  {
    production: uint,
    consumption: uint
  }
)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))

(define-read-only (get-energy-data (user principal) (timestamp uint))
  (map-get? energy-data { user: user, timestamp: timestamp })
)

(define-public (record-energy-data (production uint) (consumption uint))
  (ok (map-set energy-data
    { user: tx-sender, timestamp: block-height }
    {
      production: production,
      consumption: consumption
    }
  ))
)

(define-read-only (get-latest-energy-data (user principal))
  (map-get? energy-data { user: user, timestamp: block-height })
)

(define-read-only (calculate-net-energy (production uint) (consumption uint))
  (ok (- production consumption))
)

