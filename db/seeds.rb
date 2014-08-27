# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

puts 'DSM'
sequence_20 = ''
genome = Genome.create!(:name => 'DSM10061')
CSV.foreach(Rails.root.join('lib','data','DSM10061.csv'), :headers => :first_row) do |row|
	#skips blanks 
	if row.empty?
  		next 
  	end
  	sequence = row[0]
  	puts $.
  	puts sequence
  	starting_base_lead = row[1]
  	starting_base_lag = row[2]
  	if sequence.length == 23
  		sequence_20 = sequence
  		Mer20.create!(:sequence => sequence_20, :leading => starting_base_lead, :lagging =>  starting_base_lag,:genome_id => genome.id)
  	else 
  		parent = Mer20.find_by_sequence(sequence_20)
  		Mer14.create!(:sequence => sequence, :leading => starting_base_lead, :lagging =>  starting_base_lag, :mer20_id => parent.id)
  	end
end

puts 'LZ'

sequence_20 = ''
genome = Genome.create!(:name => 'LZ1561')
CSV.foreach(Rails.root.join('lib','data','LZ1561.csv'), :headers => :first_row) do |row|
	#skips blanks 
	if row.empty?
  		next 
  	end
  	sequence = row[0]
  	puts $.
  	puts sequence
  	starting_base_lead = row[1]
  	starting_base_lag = row[2]
  	if sequence.length == 23
  		sequence_20 = sequence
  		Mer20.create!(:sequence => sequence_20, :leading => starting_base_lead, :lagging =>  starting_base_lag,:genome_id => genome.id)
  	else 
  		parent = Mer20.find_by_sequence(sequence_20)
  		Mer14.create!(:sequence => sequence, :leading => starting_base_lead, :lagging =>  starting_base_lag, :mer20_id => parent.id)
  	end
end