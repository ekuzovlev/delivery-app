class PaymentsController < ApplicationController
  def create
    product = Product.find(params[:product_id])

    purchase_result = ApplicationBilling.new(product, current_user).make_purchase

    if purchase_result.successful?
      redirect_to :successful_payment_path
    else
      redirect_to :failed_payment_path, note: purchase_result.error_message
    end
  end
end
