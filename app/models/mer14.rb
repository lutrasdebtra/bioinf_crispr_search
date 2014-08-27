class Mer14 < ActiveRecord::Base
	belongs_to :mer20

	def self.search(query)
      # where(:title, query) -> This would return an exact match of the query
      where("sequence like ?", "%#{query}%") 
  	end
end
