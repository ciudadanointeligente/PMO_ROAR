require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Orcharding
  module BillRepresenter
    include Roar::Representer::JSON::HAL

    #TODO can this be a one liner?
    property :id
    property :title
    property :chamber

    link :self do
      bill_url(self.id)
    end
  end
end
