require "book_of_orcharding/representers/bill_representer"
require "book_of_orcharding/representers/bills_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  def index
    @bills = Bills.get("http://localhost:9292/bills", 'application/json').bills
  end

  def edit
    @bill = Bill.get(params[:id], 'application/json')
  end
end