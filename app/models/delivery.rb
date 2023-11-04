class Delivery
  attr_accessor :delivery_errors

  def initialize(vendor:, order:)
    @vendor = vendor
    @person = order.person
    @product = order.product
  end

  def setup_delivery
    response_from_delivery = retrieve_delivery_info
    create_delivery(response_from_delivery)

    notify if delivery_successful?
  end

  private

  def delivery_successful?
    delivery_errors.blank?
  end

  def create_delivery(response_from_delivery)
    Delivery.create(person: @person, vendor: @vendor, product: @product, response_from_delivery:)
  end

  def retrieve_delivery_info
    # Отправляем запрос в службу доставки с параметрами и данными по получателю, получаем response
    delivery_errors << response.status unless response.status == 'ok'

    response
  end

  def notify
    # Шлем по нужным каналам сообщение
  end
end
