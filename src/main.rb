require_relative '../src/votes_merger'

input = 'data/outputs/votes.csv'
output = 'data/outputs/merged_votes.csv'
submissions = [1, 15, 18, 25, 31,32]

merger = VoteMerger.new(input, output, submissions)
	
merger.tally_by_voter