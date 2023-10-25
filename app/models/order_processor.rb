class OrderProcessor
  def initialize(order)
    @order = order
    @user = order.user
    @product = order.product

    perform
  end

  def perform
    result_purchase = ApplicationBilling.new(product, current_user).make_purchase
    result_delivery = Delivery.new(vendor: sdek, order:).setup_delivery

    result = parse_response(result_purchase, result_delivery)

  end

  private

  def parse_response(result_purchase, result_delivery)
    if [result_purchase, result_delivery].include?(error)
      { status: error }
    else
      { status: :ok }
    end
  end
end
