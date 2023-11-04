class OrdersController < ApplicationController
  def create
    Order.new(product:, user: current_user)

    order_result = OrderProcessor.new(order).perform

    if order_result.successful?
      redirect_to :successful_order_path
    else
      redirect_to :failed_order_path, note: order_result.error_message
    end
  end
end
