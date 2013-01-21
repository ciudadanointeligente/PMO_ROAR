require 'roar/representer/json'

module Orcharding
  module BillsRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    collection :bills, :extend => BillRepresenter, :class => Bill

    def bills
      collect
    end
  end
end