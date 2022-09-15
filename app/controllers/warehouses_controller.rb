class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end 
  def new
    @warehouse = Warehouse.new()
  end 
  def create
    #Receber as informações do formulario e criar um novo Galpão
    warehouse_params = params.require(:warehouse).permit(:name, :description, :code, 
                                                        :address, :city, :cep, :area)
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
    @warehouse = Warehouse.find(params[:id])
  end
  def update
    @warehouse = Warehouse.find(params[:id])
    warehouse_params = params.require(:warehouse).permit(:name, :description, :code, 
                                                        :address, :city, :cep, :area)
    if @warehouse.update(warehouse_params)
      flash[:notice] = "Galpão atualizado com sucesso"
      redirect_to warehouse_path(@warehouse.id)
    else
      flash.now[:notice] = "Não foi possível atualizar o galpão"
      render 'edit'
    end
  end
end