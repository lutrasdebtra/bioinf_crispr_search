class Genome < ActiveRecord::Base
	has_many :mer20, :dependent => :destroy
	accepts_nested_attributes_for :mer20, :allow_destroy => true 

	has_many :mer14, :through => :mer20
end
