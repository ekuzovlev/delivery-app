class ApplicationBilling
  def initialize(product, user)
    @product = product
    @user = user
  end

  def make_purchase
    payment_result = gateway_purchase

    if payment_result.successful?
      product_access = grant_access_to_product

      notify_user(product_access)
    end

    payment_result
  end

  private

  attr_reader :product

  def gateway_purchase
    payment_gateway.proccess(
      user_uid: @user.cloud_payments_uid,
      amount_cents: product.amount_cents,
      currency: 'RUB'
    )
  end

  def grant_access_to_product
    ProductAccess.create(:user, :product)
  end

  def payment_gateway
    Cloudpayments
  end
end
