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
    
    # search_for = params.to_s
    Sunspot.remove_all(Orcharding::Bill)
    Sunspot.index!(Orcharding::Bill.all)
    
    search = Sunspot.search(Orcharding::Bill) do #.solr_search do
      fulltext params[:q]
      # fulltext search
      # keywords 'Senate' do
      #   fields(:origin_chamber)
      # end
    end
    puts "<search>"
    puts Orcharding::Bill.where(id: '511e6713d8ee064196df1ab1').first.class.name
    puts search.hits.empty?
    bills = []
    if search.hits.empty?
      key = ''
    else
      search.hits.each do |hit|
        bills.push Orcharding::Bill.where(id: hit.primary_key).first
      end
    end
    # puts Orcharding::Bill.where(id: key).first.title
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

    # respond_with Orcharding::Bill.where(id: key), represent_with: Orcharding::BillsRepresenter
    respond_with bills, represent_with: Orcharding::BillsRepresenter
  end
end