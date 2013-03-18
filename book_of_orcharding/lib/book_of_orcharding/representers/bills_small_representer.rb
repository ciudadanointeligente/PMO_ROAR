require 'roar/representer/json'

module Orcharding
  module BillsSmallRepresenter
    include Roar::Representer::JSON
    include Roar::Representer::Feature::Hypermedia

    collection :bills, :extend => BillSmallRepresenter, :class => Bill

    def bills
      collect
    end
  end
end