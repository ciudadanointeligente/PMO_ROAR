require "json"

module Orcharding
  class Seeder
    def self.load_from_json(json)
      JSON.load(json).each do |data|
        data.each do |header, seed|
          seed.map! do |data|
            data.inject({}) {|memo, (k,v)| memo[k.to_sym] = v; memo}
          end
          FruitRepository.seed = seed if header == "fruit"
          BillRepository.seed = seed if header == "bill"
        end
      end
    end
  end
end
