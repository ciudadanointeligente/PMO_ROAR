require "book_of_orcharding/representers/bill_representer"
require "book_of_orcharding/representers/bills_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  represents :json, Orcharding::Bill
  
  def index
    respond_with Orcharding::Bill.all, represent_with: Orcharding::BillsRepresenter
  end

  def show
    # respond_with Orcharding::Bill.where(id: params[:id])
    respond_with Orcharding::Bill.find_by(id: params[:id])
  end

  def search
  	bill = Orcharding::Bill.new
  	bill.uid = 1
  	bill.title = 'ExampleTitle'
  	bill.origin_chamber = 'Senado'
  	puts '<debug>'
  	puts Orcharding::Bill.where(origin_chamber: 'Senate')
  	puts '<debug>'
    
    # search_for = params.to_s
    Sunspot.remove_all(Orcharding::Bill)
    Sunspot.index!(Orcharding::Bill.all)
    
    search = Sunspot.search(Orcharding::Bill) do #.solr_search do
      fulltext 'Senate'
      # fulltext search
      # keywords 'Senate' do
      #   fields(:origin_chamber)
      # end
    end
    puts "<search>"
    key =  search.hits.first.primary_key
    puts Orcharding::Bill.where(id: key).first.title
    # search.each_hit_with_result do |hit, result|#.each do |result|
    #   puts result
    # end
      # puts result.body
    puts "</search>"
    
    # results = ''
    # search.each_hit_with_result do |hit, post|
    #   results += post.attributes.to_json
    # end
    # puts results

    respond_with bill #, represent_with: Orcharding::BillsRepresenter
  end
end