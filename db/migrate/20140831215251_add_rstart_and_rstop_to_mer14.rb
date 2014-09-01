class AddRstartAndRstopToMer14 < ActiveRecord::Migration
  def change
    add_column :mer14s, :rmax, :int
    add_column :mer14s, :rmin, :int
    Mer14.all.each do |mer|
    	nums_a = []
    	if mer.leading
    		nums_a += mer.leading.split(/\|/).map(&:to_i)
    		#puts "leading: " , mer.leading
    		#puts "nums_a: " , nums_a
    	end
    	if mer.lagging
    		nums_a += mer.lagging.split(/\|/).map(&:to_i)
    	end
    	if nums_a.length > 0
    		mer.update_attributes(:rmax => nums_a.max)
    		mer.update_attributes(:rmin => nums_a.min)
    	end
    end
  end
end
