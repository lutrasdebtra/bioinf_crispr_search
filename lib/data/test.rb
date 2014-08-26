require 'csv'

sequence_20 = ''
CSV.foreach("DSM.csv", :headers => :first_row) do |row|
	#skips blanks 
	if row.empty?
  		next 
  	end
  	sequence = row[0]
  	starting_base = row[1]
  	strand = row[4]
  	if sequence.length == 23
  		sequence_20 = sequence
  		#Mer20.create!(:sequence => sequence20, :strand => strand, :starting_base => starting_base)
  		puts row
  	else 
  		parent = Mer20.find_by_sequence(sequence_20)
  		parent.mer14s.create!(:sequence => sequence, :mer20_id => parent.id, :strand => strand, :starting_base => starting_base)
  	end
end