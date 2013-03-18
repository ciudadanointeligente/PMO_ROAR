require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Orcharding
  module EventRepresenter
    include Roar::Representer::JSON::HAL

    #TODO can this be a one liner?
    # property :session
    property :date
    property :description
    property :stage
    property :chamber

    link :self do
      bill_url(self.id)
    end
  end
end