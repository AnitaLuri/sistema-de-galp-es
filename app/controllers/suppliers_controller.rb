class SuppliersController < ApplicationController
  before_action :set_warehouse, only: [:show]

  def index
    @suppliers = Supplier.all
  end
  
  def show
  end

  private
  def set_warehouse
    @supplier = Supplier.find(params[:id])
  end
end