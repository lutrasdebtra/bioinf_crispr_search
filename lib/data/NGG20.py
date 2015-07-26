"""
NGG20
Stuart Bradley
06-08-2014

It's not fast nor pretty
A shining example of
Version 1.0

Versioning Changes
1.01 - Added direction (+/-) to SeqObject class
"""

import sys
import string
import re
import csv
import time

#########
# CLASS # 
#########

# Helper Class to hold sequence + postion. (Probably should've just used a hash).
class SeqObject:
	seq_list = {}
	def __init__(self, seq, pos, direc):
		self.seq = seq
		self.pos = str(pos)
		self.direc = direc
		if direc == '+':
			self.seq_list[seq] = self

###########
# METHODS #
###########

# Finds ng20 sequences.
def find_ngg20(strand, direc):
	seq_objects = []
	# Finds all objects using regex.
	seqs = re.findall(r'[ATCG]GG[ATCG]{20}', strand)
	# Finds all positions for objects.
	pos = [m.start() for m in re.finditer(r'[ATCG]GG[ATCG]{20}', strand)]
	# For each sequence, create a sequence object (See class).
	for i in range(len(seqs)):
		seq_objects.append(SeqObject(seqs[i], pos[i], direc))
	return seq_objects

# Does all the processing of the NGG20s. 
def ngg20_output(seqs, a, lead, lag):
	counter = 0
	len_seqs = len(seqs)
	# For each NGG20
	for seq in seqs:
		counter += 1
		print str(counter) + "/" + str(len_seqs) + " (" + seq.direc + ")"
		# Spacer.
		a.writerow([])
		# Add NGG20 line
		a.writerow([seq.seq, seq.pos, '', '', seq.direc])
		# Get 14mers (See method).
		mers = get_14mers(seq)
		# For each 14mer
		for mer in mers:
			# Search + and - strands for matches, return positions and strand info (see method).
			matches_lead, direc_lead = mer_output(mer, lead, '+')
			matches_lag, direc_lag = mer_output(mer, lag, '-')
			# Work out which strand has matches, and print correct output to file. 
			if len(matches_lead) > 0 and len(matches_lag) > 0:
				a.writerow([mer.seq, mer.pos, 'yes', matches_lead + "||" + matches_lag, direc_lead + "||" + direc_lag])
			elif len(matches_lead) == 0 and len(matches_lag) > 0:
				a.writerow([mer.seq, mer.pos, 'yes', matches_lag, direc_lag])
			elif len(matches_lead) > 0 and len(matches_lag) == 0:
				a.writerow([mer.seq, mer.pos, 'yes', matches_lead, direc_lead])
			else:
				a.writerow([mer.seq, mer.pos, 'no', '', ''])

# Returns a list of 14mers
def get_14mers(seq):
	mers = []
	pos = seq.pos
	if '|' in seq.pos:
		pos = seq.pos.split('|')[0]
	for i in range(0,10):
		mers.append(SeqObject(seq.seq[i:i+14], int(pos)+i, seq.direc))
	return mers

def mer_output(mer, strand, direc):
	pos = [m.start() for m in re.finditer(mer.seq, strand)]
	matches = ''
	direct = ''
	for p in pos:
		matches += "|" + str(p)
		direct += "|" + direc
	return matches[1:], direct[1:]

# Remove duplicates in a set of objects.
def unique_ngg20_strand(seq_objs):
	list_of_uni = {}
	for o in seq_objs:
		pos = o.pos
		if o.seq in list_of_uni:
			list_of_uni[o.seq].pos += '|' + str(pos)
			print list_of_uni[o.seq].pos 
		else:
			list_of_uni[o.seq] = o
	return list_of_uni.values()

# Combine +/- strand NGG20 objects
def ngg20_combine(lead, lag):
	for o in lag:
		pos = o.pos
		if o.seq in SeqObject.seq_list:
			SeqObject.seq_list[o.seq].pos += '|' + str(pos)
			SeqObject.seq_list[o.seq].direc += '|' + '-'
	return SeqObject.seq_list.values()
########
# MAIN # 
########

start = time.clock() 
# Get File from Sys Args.
inputFile = str(sys.argv[1])
outputFile = inputFile.split(".")[0]
sequences = []
sequence_lead = ""
sequence_lag = ""

# Read in Fasta File.
with open(inputFile,'rb') as f1:
	for line in f1:
		if line.startswith(">"):
			sequence_lead = ""
		else:
			sequence_lead += line.rstrip()

# Create leading and lagging uppercase strands.
sequence_lead = sequence_lead.upper()
sequence_lag = sequence_lead.translate(string.maketrans('TAGC', 'ATCG'))[::-1]

# Find all ngg20 sequences (See method).
list_of_uni = []
ngg20_lead = unique_ngg20_strand(find_ngg20(sequence_lead, '+'))
ngg20_lag = unique_ngg20_strand(find_ngg20(sequence_lag, '-'))

# Open and begin writing to CSV.
with open(outputFile+'.csv', 'wb') as fp:
    a = csv.writer(fp, delimiter=',')
    # Create Header.
    a.writerow(['3_mer', 'starting_base', 'matching_14mer', 'starting_base_matches', 'strand'])
    # Process NGG20s on both strands (see method).
    ngg20_output(ngg20_combine(ngg20_lead, ngg20_lag), a, sequence_lead, sequence_lag)

elapsed = time.clock()
elapsed = elapsed - start
print "Time spent in program is: ", elapsed