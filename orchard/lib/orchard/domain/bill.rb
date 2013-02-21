module Orcharding
  require 'sunspot_mongoid'
  Mongoid.logger = nil
  
  class Bill
    #extend RepositoryFactory
    #include HashSerialization
    include Mongoid::Document
    include Mongoid::Timestamps

    field :uid, :type => String# ,:meta => ['search'=>'text', 'display_name'=>'Boletin', 'link_to_detail'=>true, 'should_be_shown_in_list'=>true]
    field :title, :type => String# ,:meta => ['search'=>'text','display_name'=>'Titulo', 'should_be_shown_in_list'=>true]
    # field :summary, :type => String ,:meta => ['search'=>'false','display_name'=>'Resumen', 'should_be_shown_in_list'=>false]
    # field :tags, :type => Array ,:meta => ['search'=>'list','display_name'=>'Tags', 'should_be_shown_in_list'=>false]
    # field :matters, :type => Array ,:meta => ['search'=>'list','display_name'=>'Materias', 'should_be_shown_in_list'=>false, 'valid_values'=>matters_valid_values]
    # field :stage, :type => String ,:meta => ['search'=>'list','display_name'=>'Etapa', 'should_be_shown_in_list'=>true, 'valid_values'=>stage_valid_values]            # Current Stage
    # field :creation_date, :type => DateTime ,:meta => ['search'=>'date','display_name'=>'Fecha de Creación', 'should_be_shown_in_list'=>true]
    # field :publish_date, :type => DateTime ,:meta => ['search'=>'date','display_name'=>'Fecha Publicación', 'should_be_shown_in_list'=>true]
    # field :authors, :type => Array ,:meta => ['search'=>'list','display_name'=>'Autores', 'should_be_shown_in_list'=>false]
    field :origin_chamber, :type => String# ,:meta => ['search'=>'list','display_name'=>'Cámara de origen', 'should_be_shown_in_list'=>false, 'valid_values'=>origin_chamber_valid_values]
    # field :current_urgency, :type => String ,:meta => ['search'=>'list','display_name'=>'Urgencia', 'should_be_shown_in_list'=>false, 'valid_values'=>current_urgency_valid_values]
    # field :table_history, :type => Array ,:meta => ['should_be_shown_in_list'=>false]
    # field :link_law, :type => Array ,:meta => ['search'=>'text','display_name'=>'Link a la ley', 'should_be_shown_in_list'=>false]

    include Sunspot::Mongoid
  #  searchable :auto_remove => true do
    searchable do
      text :uid#, :stored => true
      text :title#, :stored => true
      #text :summary
      #text :stage
      #time :creation_date
      #time :publish_date
      text :origin_chamber
      #text :current_urgency
    end


    #attr_accessor :uid, :title, :origin_chamber


    # def initialize(params = {})
    #   super(params)
    #   from_hash params
    # end

    # def update(params = {})
    #   from_hash params.reject {|param, value| [:id].include?(param)}
    #   self.class.repository.update to_hash
    # end

    # class << self
    #   def all
    #     repository.all.map do |data|
    #       new_from_hash data
    #     end
    #   end

    #   def find_by_id(id)
    #     new_from_hash repository.find_by_id(id)
    #   end

    #   def find_by_chamber(chamber)
    #     repository.find_by_chamber(chamber).map do |data|
    #       new_from_hash data
    #     end
    #   end

    #   def create(data)
    #     new_from_hash repository.create(data)
    #   end

    #   def destroy(id)
    #     repository.destroy(id)
    #   end
    # end

  end
end
