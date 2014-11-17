class Direccion < ActiveRecord::Base

	belongs_to :comuna
	belongs_to :hogar

	validates :direccion, presence: true
	validates :numero, presence: true

end
