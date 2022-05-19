require_relative '../src/votes_merger'

RSpec.describe 'Vote Merging' do
	let(:samples_folder) { 'spec/samples/' }
	let(:outputs_folder) { 'spec/outputs/' }
	let(:submissions) { [32] }

	it "converts a csv with a single praises into a json of the specified format" do
		testfile = 'single_vote'
		input = samples_folder + + 'sample_' + testfile + '.csv'
		output = outputs_folder + testfile + '_E2E_output.csv'
		expected = samples_folder + 'sample_' + testfile + '_output.csv'
		merger = VoteMerger.new(input, output, submissions, mode: 'test')

		merger.tally_by_voter
		expect(File.read(output)).to eq(File.read(expected))
	end

	context "a praise array" do
		let(:testfile) { 'sample_vote_array' }
		let(:input_csv) { samples_folder + testfile + '.csv' }
		let(:submissions) { [23,31,34] }

		it "converts a csv with an array of votes" do
			output_json = outputs_folder + testfile + '.csv'
			expected_json = samples_folder + testfile + '_output.csv'
			merger = VoteMerger.new(input_csv, output_json, submissions, mode: 'test')

			merger.tally_by_voter

			expect(File.read(output_json)).to eq(File.read(expected_json))
		end
	end
end