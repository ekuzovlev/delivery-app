class Delivery
  def initialize(vendor:, order:)
    @vendor = vendor
    @person = order.person
    @product = order.product
  end

  def setup_delivery
    get_delivery_params

    if get_delivery_params.status == 'ok' && delivery_create
      notify
      { status: :ok }
    else
      { status: error }
    end
  end

  private

  def delivery_create
    Delivery.create(@person, @vendor, @product)
  end

  def get_delivery_params
    # Отправляем запрос в службу доставки с параметрами и данными по получателю
  end

  def notify
    # Шлем по нужным каналам сообщение
  end
end
