require "book_of_orcharding/representers/bill_representer"
require "book_of_orcharding/representers/bills_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  represents :json, Orcharding::Bill
  
  def index
    respond_with Orcharding::Bill.all, represent_with: Orcharding::BillsRepresenter
  end

  def show
    respond_with Orcharding::Bill.find_by_id(params[:id])
  end
end