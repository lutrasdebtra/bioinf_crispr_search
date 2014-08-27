class Mer20 < ActiveRecord::Base
	has_many :mer14, :dependent => :destroy
	accepts_nested_attributes_for :mer14, :allow_destroy => true 

  	def self.getChildren(mer)
  		return mer.mer14.unshift(mer)
  	end

	def self.search(query, genome)
      if genome == 0
      	mer = where("sequence like ?", "%#{query}%") 
      else 
      	mer = where("genome_id like ?", "%#{genome}").where("sequence like ?", "%#{query}%") 
      end
      return getChildren(mer[0])
  	end

  	def self.splitStarts(starts)
  	  if starts
  	    return starts.gsub "|", ",\n" 
  	  end
  	end
end
