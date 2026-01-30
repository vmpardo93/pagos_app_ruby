class ProcessPayment
  BASE_FEE = 2.50
  DELIVERY_FEE = 5.00

  def initialize(product_repository:, transaction_repository:, payment_service:)
    @product_repository = product_repository
    @transaction_repository = transaction_repository
    @payment_service = payment_service
  end

  def call(product_id:, quantity:, card_token:)
    product = @product_repository.find(product_id)
    raise 'Product not found' unless product
    raise 'Insufficient stock' unless product.stock >= quantity

    total_amount = (product.price * quantity) + BASE_FEE + DELIVERY_FEE

    transaction = Transaction.new(
      transaction_number: SecureRandom.uuid,
      amount: total_amount,
      product_id: product.id,
      quantity: quantity
    )

    @transaction_repository.save(transaction)

    result = @payment_service.pay(amount: total_amount, card_token: card_token)

    if result[:status] == 'APPROVED'
      transaction.mark_success!(result[:reference])
      product.decrease_stock!(quantity)
      @product_repository.save(product)
    else
      transaction.mark_failed!
    end

    @transaction_repository.save(transaction)
    transaction
  end
end
