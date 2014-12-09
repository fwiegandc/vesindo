class Direccion < ActiveRecord::Base
  attr_accessor :activation_token
   # auto-fetch coordinates

  # Create a simple mercator factory. This factory itself is
  # geographic (latitude-longitude) but it also contains a
  # companion projection factory that uses EPSG 3785.
  FACTORY = RGeo::Geographic.simple_mercator_factory

  # We're storing data in the database in the projection.
  # So data gotten straight from the "loc" attribute will be in
  # projected coordinates.
  set_rgeo_factory_for_column(:loc, FACTORY.projection_factory)

	belongs_to :comuna
	belongs_to :hogar

	validates :direccion, presence: true
	validates :numero, presence: true
  validates :comuna, presence: true
  validates :loc, presence: true

  validates_uniqueness_of :direccion, scope: [:numero, :bloque, :dpto, :comuna]

  before_create :create_activation_digest

  #after_validation :geocode #, :if => :direccion_y_numero_changed?
  #geocoded_by :direccion_y_numero do |obj, results|
  #  if geo = results.first
  #    obj.loc = FACTORY.point(geo.longitude, geo.latitude).projection
  #  end
  #end

  def enviar_validacion
    #Generamos la carta de verificacion
    pdf = WickedPdf.new.pdf_from_string("<h1>¡Hola #{self.hogar.user_admin.name}!</h1> <p>Su código de validación es #{self.activation_token} </p> <p> Un abrazo afectuoso,</p> <p> El equipo de Vesindo</p>", encoding: "UTF-8")
    save_path = Rails.root.join('pdfs',"#{self.hogar.user_admin.name}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  # To interact in projected coordinates, just use the "loc"
  # attribute directly.
  def loc_projected
    self.loc
  end
  def loc_projected=(value)
    self.loc = value
  end

  # To use geographic (lat/lon) coordinates, convert them using
  # the wrapper factory.
  def loc_geographic
    FACTORY.unproject(self.loc)
  end
  def loc_geographic=(value)
    self.loc = FACTORY.project(value)
  end

  def loc_geographic_lat_lon(lat, lon)
    self.loc_geographic = FACTORY.point(lat, lon)
  end

  #Empezamos con la validación de las direcciones
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def Direccion.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

      # Creates and assigns the activation token and digest.
  def create_activation_digest
      self.activation_token  = Direccion.new_token
      self.activation_digest = Direccion.digest(activation_token)
  end

  def Direccion.new_token
    #generamos un token leible para el usuario
    rand(99999)
  end

  #y los mails de envío
  def send_direccion_codigo_email
    UserMailer.password_reset(self).deliver
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end


end
