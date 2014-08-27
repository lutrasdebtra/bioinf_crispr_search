class Mer14 < ActiveRecord::Base
	belongs_to :mer20


	def self.getChildren(mer)
  		set = []
  		mer.each do |m|
  			set += Mer20.getChildren(Mer20.find(m.mer20_id))
  		end
  		return set
  	end

	def self.search(query, genome)
      if genome == 0
        mer = where("sequence like ?", "%#{query}%") 
      else 
      	mer = where("genome_id like ?", "%#{genome}").where("sequence like ?", "%#{query}%") 
      end
      return getChildren(mer)
  	end

  	def self.splitStarts(starts)
  	  if starts
  	    return starts.gsub! "|", ",\n" 
  	  end
  	end
end
