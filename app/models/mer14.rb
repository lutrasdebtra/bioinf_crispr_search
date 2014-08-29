class Mer14 < ActiveRecord::Base
	belongs_to :mer20

	def self.search_mer(query, genome)
      if genome == 0
      	mer = where("sequence = ?", query) 
      else 
      	mer = where("genome_id = ?", genome.to_i).where("sequence = ?", query) 
      end
      return Genome.getRelation(mer)
  	end

  	def self.start_search(query, genome)
      if genome == 0
      	mer = where("leading = ? OR lagging = ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ?", query.to_i, query.to_i, "#{query}|%", "#{query}|%", "%|#{query}|%", "%|#{query}|%", "%|#{query}", "%|#{query}") 
      else 
      	mer = where("genome_id = ?", genome.to_i).where("leading = ? OR lagging = ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ?", query.to_i, query.to_i, "#{query}|%", "#{query}|%", "%|#{query}|%", "%|#{query}|%", "%|#{query}", "%|#{query}") 
      end

      return Genome.getRelation(mer)
  	end
end
