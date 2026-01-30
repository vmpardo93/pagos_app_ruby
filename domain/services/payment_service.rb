class PaymentService
  def pay(amount:, card_token:)
    # Simulación Wompi
    success = [true, false].sample

    if success
      { status: 'APPROVED', reference: SecureRandom.hex(8) }
    else
      { status: 'DECLINED' }
    end
  end
end