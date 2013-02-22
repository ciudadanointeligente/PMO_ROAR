# encoding: utf-8
module Orcharding
  require 'sunspot_mongoid'
  Mongoid.logger = nil
  
  class Bill
    #extend RepositoryFactory
    #include HashSerialization
    include Mongoid::Document
    include Mongoid::Timestamps

    # Field Validation
    matters_valid_values =
      [
        'Defensa',
        'Impuestos',
        'Economía',
        'Empresas',
        'Hacienda',
        'Relaciones Exteriores',
        'Administración',
        'Asunto Indígena',
        'Zona Extrema',
        'Regionalización',
        'Salud',
        'Minería',
        'Medio Ambiente',
        'Derechos Animales',
        'Vivienda',
        'Obras Públicas',
        'Transporte',
        'Telecomunicaciones',
        'Trabajo',
        'Protección Social',
        'Cultura',
        'Educación',
        'Deportes',
        'Transparencia',
        'Probidad',
        'Elecciones',
        'Participación',
        'Familia',
        'Seguridad',
        'Derechos Fundamentales',
        'Nacionalidad',
        'Reconstrucción Terremoto'
      ]
    stage_valid_values =
      [
        'Archivado',
        'Comisión Mixta Ley de Presupuesto',
        'Comisión Mixta por rechazo de idea de legislar',
        'Comisión Mixta por rechazo de modificaciones',
        'Disc. informe C.Mixta por rechazo de modific. en C...',
        'Discusión veto en Cámara de Origen',
        'Discusión veto en Cámara Revisora',
        'Insistencia',
        'Primer trámite constitucional',
        'Retirado',
        'Segundo trmáite constitucional',
        'Tercer trámite constitucional',
        'Tramitación terminada',
        'Trámite de aprobacion presidencial',
        'Trámite finalización en Cámara de Origen'
      ]
    origin_chamber_valid_values =
      [
        'C.Diputados',
        'Senado'
      ]
    current_urgency_valid_values =
      [
        'Discusión inmediata',
        'Simple',
        'Sin urgencia',
        'Suma'
      ]

    validates_presence_of :uid
    validates_uniqueness_of :uid
    validates :matters, inclusion: { in: matters_valid_values }
    validates :stage, inclusion: { in: stage_valid_values }
    validates :origin_chamber, inclusion: { in: origin_chamber_valid_values }
    validates :current_urgency, inclusion: { in: current_urgency_valid_values }

    # Relations
    # embeds_many :events, :autosave => true
  #  add reference to tables (probably a table array)
  #  belongs_to :table  

    # Fields
    field :uid, :type => String ,:metadata => ['search'=>'text', 'display_name'=>'Boletin', 'link_to_detail'=>true, 'should_be_shown_in_list'=>true]
    field :title, :type => String ,:metadata => ['search'=>'text','display_name'=>'Titulo', 'should_be_shown_in_list'=>true]
    field :summary, :type => String ,:metadata => ['search'=>'false','display_name'=>'Resumen', 'should_be_shown_in_list'=>false]
    field :tags, :type => Array ,:metadata => ['search'=>'list','display_name'=>'Tags', 'should_be_shown_in_list'=>false]
    field :matters, :type => Array ,:metadata => ['search'=>'list','display_name'=>'Materias', 'should_be_shown_in_list'=>false, 'valid_values'=>matters_valid_values]
    field :stage, :type => String ,:metadata => ['search'=>'list','display_name'=>'Etapa', 'should_be_shown_in_list'=>true, 'valid_values'=>stage_valid_values]            # Current Stage
    field :creation_date, :type => DateTime ,:metadata => ['search'=>'date','display_name'=>'Fecha de Creación', 'should_be_shown_in_list'=>true]
    field :publish_date, :type => DateTime ,:metadata => ['search'=>'date','display_name'=>'Fecha Publicación', 'should_be_shown_in_list'=>true]
    field :authors, :type => Array ,:metadata => ['search'=>'list','display_name'=>'Autores', 'should_be_shown_in_list'=>false]
    field :origin_chamber, :type => String ,:metadata => ['search'=>'list','display_name'=>'Cámara de origen', 'should_be_shown_in_list'=>false, 'valid_values'=>origin_chamber_valid_values]
    field :current_urgency, :type => String ,:metadata => ['search'=>'list','display_name'=>'Urgencia', 'should_be_shown_in_list'=>false, 'valid_values'=>current_urgency_valid_values]
    field :table_history, :type => Array ,:metadata => ['should_be_shown_in_list'=>false]
    field :link_law, :type => Array ,:metadata => ['search'=>'text','display_name'=>'Link a la ley', 'should_be_shown_in_list'=>false]

    # Indexes
    # index :uid#, :unique => true
    # index :tags
    # index :matters

    def get_metadata
      return {
        'title'=>self.title
      }
    end

    include Sunspot::Mongoid
  #  searchable :auto_remove => true do
    searchable do
      text :uid#, :stored => true
      text :title#, :stored => true
      text :summary
      text :stage
      time :creation_date
      time :publish_date
      text :origin_chamber
      text :current_urgency
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
