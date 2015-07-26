# CRISPR Search 

A somewhat specific tool that uses user inputed sequence (or fasta files), to locate CRISPR sequences inside either E. Coli or a specific Clostridium strain. 

## Initalizing CRISPR Search

The web application itself is a simple Rails App and requires no more setup than:

`db:setup`
  
The initial seed process will take some time. What happens is the seed file processes a CSV where each row is a CRISPR sequence of length 14 or length 20, into seperate databases. Each row also contains a small amount of meta-data to help distingish leading and lagging strands.

## Adding New Organisms

To add a new organism to the search system, four things need to happen:

1. Inside `/lib/data/` there is a file called `NGG20.py`. This file takes a fasta file of sequence and finds all CRISPR sequences, before outputting to a CSV file. 
2. The `seeds.rb` file needs to be updated to add the newly created CSV file. This can easily be done by changing the file name in the seed file to the new CSV.
3. A new checkbox needs to added to `/app/views/layouts/application.html.erb/`. It is a relatively straight-forward process, and the code in the file can be reused. The number parameter that is sent to the controller will need to be the same as the genome id in the database..
4. The controller in `/app/controllers/mer20s_controller.rb/` must be modifed to do the search based on the new parameter. Currently, it is designed for two genomes, but could easily be expanded for many more. 
