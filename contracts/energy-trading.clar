;; Energy Trading Contract

(define-map energy-offers
  { offer-id: uint }
  {
    seller: principal,
    energy-amount: uint,
    price: uint,
    expiration: uint
  }
)

(define-map energy-trades
  { trade-id: uint }
  {
    seller: principal,
    buyer: principal,
    energy-amount: uint,
    price: uint,
    timestamp: uint
  }
)

(define-data-var offer-id-nonce uint u0)
(define-data-var trade-id-nonce uint u0)
(define-data-var active-offer-count uint u0)

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u403))
(define-constant ERR_NOT_FOUND (err u404))
(define-constant ERR_EXPIRED (err u410))

(define-read-only (get-energy-offer (offer-id uint))
  (map-get? energy-offers { offer-id: offer-id })
)

(define-read-only (get-energy-trade (trade-id uint))
  (map-get? energy-trades { trade-id: trade-id })
)

(define-public (create-energy-offer (energy-amount uint) (price uint) (expiration uint))
  (let
    ((new-offer-id (+ (var-get offer-id-nonce) u1)))
    (map-set energy-offers
      { offer-id: new-offer-id }
      {
        seller: tx-sender,
        energy-amount: energy-amount,
        price: price,
        expiration: expiration
      }
    )
    (var-set offer-id-nonce new-offer-id)
    (var-set active-offer-count (+ (var-get active-offer-count) u1))
    (ok new-offer-id)
  )
)

(define-public (cancel-energy-offer (offer-id uint))
  (let
    ((offer (unwrap! (map-get? energy-offers { offer-id: offer-id }) ERR_NOT_FOUND)))
    (asserts! (is-eq (get seller offer) tx-sender) ERR_UNAUTHORIZED)
    (map-delete energy-offers { offer-id: offer-id })
    (var-set active-offer-count (- (var-get active-offer-count) u1))
    (ok true)
  )
)

(define-public (accept-energy-offer (offer-id uint))
  (let
    ((offer (unwrap! (map-get? energy-offers { offer-id: offer-id }) ERR_NOT_FOUND))
     (new-trade-id (+ (var-get trade-id-nonce) u1)))
    (asserts! (< block-height (get expiration offer)) ERR_EXPIRED)
    (map-set energy-trades
      { trade-id: new-trade-id }
      {
        seller: (get seller offer),
        buyer: tx-sender,
        energy-amount: (get energy-amount offer),
        price: (get price offer),
        timestamp: block-height
      }
    )
    (map-delete energy-offers { offer-id: offer-id })
    (var-set trade-id-nonce new-trade-id)
    (var-set active-offer-count (- (var-get active-offer-count) u1))
    (ok new-trade-id)
  )
)

(define-read-only (get-active-offer-count)
  (ok (var-get active-offer-count))
)

