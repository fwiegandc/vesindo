class Direccion < ActiveRecord::Base

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

  #after_validation :geocode #, :if => :direccion_y_numero_changed?
  #geocoded_by :direccion_y_numero do |obj, results|
  #  if geo = results.first
  #    obj.loc = FACTORY.point(geo.longitude, geo.latitude).projection
  #  end
  #end

  def direccion_y_numero
    "#{self.direccion}, #{self.numero}, #{self.comuna.name}, Region Metropolitana, Chile"
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

end
