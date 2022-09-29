class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new()
    @warehouses = Warehouse.all 
    @suppliers = Supplier.all
  end
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save()
      flash[:notice] = "Pedido registrado com sucesso!"
      redirect_to @order
    else
      @suppliers = Supplier.all
      @warehouses = Warehouse.all 
      flash.now[:notice] = "Não é possível registrar o pedido."
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      flash[:alert] = "Você não possui acesso a este pedido."
      redirect_to root_path
    end
  end

  def search
    @code = params["query"]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Pedido atualizado com sucesso."
      redirect_to order_path(@order.id)
    else
      flash.now[:notice] = "Não foi possível atualizar o pedido."
      render 'edit'
    end
  end

  private
  def order_params
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :user_id, :estimated_delivery_date)
  end
end