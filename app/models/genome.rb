class Genome < ActiveRecord::Base
	has_many :mer20, :dependent => :destroy
	accepts_nested_attributes_for :mer20, :allow_destroy => true 
end
