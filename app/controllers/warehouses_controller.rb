class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy] 
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
  end 

  def new
    @warehouse = Warehouse.new()
  end 

  def create
    #Receber as informações do formulario e criar um novo Galpão
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      flash[:notice] = "Galpão cadastrado com sucesso!"
      redirect_to root_path
    else
      flash.now[:notice] = "Galpão não cadastrado."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @warehouse.update(warehouse_params)
      flash[:notice] = "Galpão atualizado com sucesso"
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = "Não foi possível atualizar o galpão"
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = "Galpão removido com sucesso"
    redirect_to root_path
  end

  private
  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
  def warehouse_params
    warehouse_params = params.require(:warehouse).permit(:name, :description, :code, 
                                                        :address, :city, :state, :cep, :area)
  end
end