class Mer20 < ActiveRecord::Base
	has_many :mer14, :dependent => :destroy
	accepts_nested_attributes_for :mer14, :allow_destroy => true 

	def self.search(query)
      # where(:title, query) -> This would return an exact match of the query
      where("sequence like ?", "%#{query}%") 
  	end
end
