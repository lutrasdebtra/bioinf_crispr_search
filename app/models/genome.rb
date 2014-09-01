class Genome < ActiveRecord::Base
	has_many :mer20, :dependent => :destroy
	accepts_nested_attributes_for :mer20, :allow_destroy => true 

	has_many :mer14, :through => :mer20

	def self.getRelation(mer)
		set = []
		mer.each do |m|
			if m.sequence.length == 23
  				set += m.mer14.unshift(m)
  			elsif m.sequence.length == 14
  				parent = Mer20.find(m.mer20_id)
  				set += parent.mer14.unshift(parent)
  			end
  		end
  		return set.uniq
	end

	def self.splitStarts(starts)
  	  if starts
  	    return starts.gsub "|", ",\n" 
  	  end
  end

  def self.isMatch(query, mer)
    if mer.sequence == query
      return true
    end
    if mer.leading
      leading_array = mer.leading.split(/\|/)
      if leading_array.include?(query)
        return true
      end
    end
    if mer.lagging
      lagging_array = mer.lagging.split(/\|/)
      if lagging_array.include?(query)
        return true
      end
    end
    return false
  end

end
