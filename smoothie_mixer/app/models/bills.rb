require 'roar/representer/feature/client'

class Bills < OpenStruct
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Orcharding::BillsRepresenter
    extend Roar::Representer::Feature::Client
    transport_engine = Roar::Representer::Transport::Faraday
  end
end

