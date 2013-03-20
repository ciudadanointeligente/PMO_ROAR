require "book_of_orcharding/representers/bill_representer"
require "book_of_orcharding/representers/bills_representer"
require "book_of_orcharding/representers/bill_small_representer"
require "book_of_orcharding/representers/bills_small_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  represents :json, Orcharding::Bill
  
  def index
    respond_with Orcharding::Bill.all.without(:events, :urgencies, :reports), represent_with: Orcharding::BillsRepresenter
  end
  
  def index_small
    respond_with Orcharding::Bill.all, represent_with: Orcharding::BillsSmallRepresenter
  end

  def update
    # respond_with Orcharding::Bill.where(id: params[:id])
    puts "<params>"
    puts params[:bill]
    puts "</params>"
    json = params[:bill].to_hash
    puts "hash created"
    puts "<json>"
    # puts json.except('events')
    # puts json['events'].to_hash
    puts json['events'].first.class.name
    # puts json
    puts "</json>"
    bill = Orcharding::Bill.new(json.except('events'))
    puts "bill created"
    
    events = []
    json['events'].each do |json_event|
      event = Orcharding::Event.new(json_event.to_hash)
      # event.save
      events.push event
    end
    bill['events'] = events

    # bill['events'] = json['events']
    # puts "event created"
    # puts bill.uid
    bill.save! :validate => false
    # puts 'bill saved'
    # puts Orcharding::Bill.find_by(uid: bill.uid)
  end

  def show
    # respond_with Orcharding::Bill.where(id: params[:id])
    # uid = params[:uid].present? ? params[:uid] : params[:id]
    # respond_with Orcharding::Bill.find_by(uid: uid), represent_with: Orcharding::BillsRepresenter
    respond_with Orcharding::Bill.find_by(uid: params[:id]), represent_with: Orcharding::BillRepresenter
    # respond_with Orcharding::Bill.new({uid: '1', title: 'Title bills_controller 55', origin_chamber: 'Senado', stage: 'Archivado', current_urgency: 'Suma'}), represent_with: Orcharding::BillRepresenter
  end

  def search
  	# bill = Orcharding::Bill.new
  	# bill.uid = 1
  	# bill.title = 'ExampleTitle'
  	# bill.origin_chamber = 'Senado'
    
    # search_for = params.to_s
    # Sunspot.remove_all(Orcharding::Bill)
    # Sunspot.index!(Orcharding::Bill.all)
    
    search = Sunspot.search(Orcharding::Bill) do #.solr_search do
      fulltext params[:q]
      # fulltext search
      # keywords 'Senate' do
      #   fields(:origin_chamber)
      # end
    end
    puts "<search>"
    # puts Orcharding::Bill.where(id: '511e6713d8ee064196df1ab1').first.class.name
    # puts search.hits.empty?
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