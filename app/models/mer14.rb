class Mer14 < ActiveRecord::Base
	belongs_to :mer20

	# Depreciated currently, full sequence search is used. 
	def self.search_mer(query, genome)
      if genome == 0
      	mer = where("sequence = ?", query) 
      else 
      	mer = where("genome_id = ?", genome.to_i).where("sequence = ?", query) 
      end
      return Genome.getRelation(mer)
  	end

  	# If an integer is given, check mer start positions.
  	def self.start_search(query, genome)
      if genome == 0
      	mer = where("leading = ? OR lagging = ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ?", query.to_i, query.to_i, "#{query}|%", "#{query}|%", "%|#{query}|%", "%|#{query}|%", "%|#{query}", "%|#{query}") 
      else 
      	mer = where("genome_id = ?", genome.to_i).where("leading = ? OR lagging = ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ? OR leading like ? OR lagging like ?", query.to_i, query.to_i, "#{query}|%", "#{query}|%", "%|#{query}|%", "%|#{query}|%", "%|#{query}", "%|#{query}") 
      end
      return Genome.getRelation(mer)
  	end

  	# If int - int is given, look for mers starting in range. 
  	def self.range_search(start, stop, genome)
  	  if genome == 0
      	mer = where("rmin >= ?", start).where("rmax <= ?", stop)
      else 
      	mer = where("genome_id = ?", genome.to_i).where("rmin >= ?", start).where("rmax <= ?", stop)
      end
      return Genome.getRelation(mer)
    end

    # Searches sequences for matches to the query sequence. 
    def self.sequence_search(query, genome)
      mer = []
      if genome == 0
      	Mer14.find_each do |m| 
      	  if query.include?(m.sequence)
      	  	mer << m
      	  end
      	end 
      else 
      	mers = where("genome_id = ?", genome.to_i)
      	mers.each do |m|
      	  if query.include?(m.sequence)
      	    mer << m
      	  end
      	end 
      end
      return Genome.getRelation(mer)
    end
end
