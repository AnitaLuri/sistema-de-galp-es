class OrdersController < ApplicationController
  def new
    @order = Order.new()
    @warehouses = Warehouse.all 
    @suppliers = Supplier.all
  end
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save!
      flash[:notice] = "Pedido registrado com sucesso!"
      redirect_to @order
    else
      @suppliers = Supplier.all
      @warehouses = Warehouse.all 
      flash.now[:notice] = "Pedido não registrado."
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :user_id, :estimated_delivery_date)
  end
end