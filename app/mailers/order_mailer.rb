class OrderMailer < ApplicationMailer
  def new_order
    @order = params[:order]
    @store = @order.store
    @products = @order.products
    mail(to: @store.email, subject: 'Nueva orden generada')
  end
end
