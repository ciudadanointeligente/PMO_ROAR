require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Orcharding
  module BillSmallRepresenter
    include Roar::Representer::JSON::HAL

    #TODO can this be a one liner?
    property :uid
    property :title

    # collection :events, :extend => EventRepresenter, :class => Event

    link :self do
      bill_url(self.uid)
    end
  end
end