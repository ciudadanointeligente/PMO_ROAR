require 'roar/representer/json'

module Orcharding
  module BillsRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    # property :total_entries
    
    collection :bills, :extend => BillRepresenter, :class => Bill

    #opts[:bowl] == all by default
    # link :self do |opts|
    #   bills_url(opts[:bills], :page => current_page)
    # end
 
  	# link :next do |opts|
   #    bills_url(opts[:bills], :page => next_page) \
   #      if next_page
   #  end
 
   #  link :previous do |opts|
   #    bills_url(opts[:bills], :page => previous_page) \
   #      if previous_page
   #  end
 
    def items
      self
    end

    def bills
      collect
    end
  end
end