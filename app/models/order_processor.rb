# frozen_string_literal: true

# This class is responsible for processing completed orders,
# specifically handling payment and delivery tracking.
class OrderProcessor
  attr_accessor :errors

  def initialize(order)
    @order = order
    @user = order.user
    @product = order.product
  end

  def perform
    purchase
    return unless purchase.errors.blank? # TODO: реализовать обработку ошибок в классе Purchase

    delivery
  end

  private

  def purchase
    result_purchase = ApplicationBilling.new(product: @product, user: current_user).make_purchase

    @errors << result_purchase.purchase_errors
  end

  def delivery
    result_delivery = Delivery.new(vendor: :sdek, order: @order).setup_delivery

    @errors << result_delivery.delivery_errors
  end

  def successful?
    @errors.blank?
  end
end
