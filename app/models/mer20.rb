class Mer20 < ActiveRecord::Base
	has_many :mer14, :dependent => :destroy
	accepts_nested_attributes_for :mer14, :allow_destroy => true 
end
