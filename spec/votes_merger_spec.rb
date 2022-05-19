require_relative '../src/votes_merger'


RSpec.describe VoteMerger do
	let(:outputs_folder) { 'spec/outputs/' }
	let(:merger) { VoteMerger.new(input, output, submissions, mode: 'test') }

	def open_csv(file)
		CSV.read(file, headers: true)
	end

	context "a single vote" do
		let(:samples_folder) { 'spec/spec_data/' }
		let(:input) { samples_folder + 'spec_input_single.csv' }
		let(:output) { outputs_folder + 'spec_output_single.csv' }
		let(:submissions) { [32] }

		it "handles them as expected" do
			expected_json = samples_folder + 'sample_output_single.csv'
			merger.tally_by_voter

			expect(File.read(output)).to eq(File.read(expected_json))			
		end
	end

	context "multiple votes" do
		testfile = 'discord_single_receiver_praise'
		let(:samples_folder) { 'spec/spec_data/' }
		let(:input) { samples_folder + 'spec_input_multi.csv' }
		let(:output) { outputs_folder + 'spec_output_multi.csv' }
		let(:submissions) { [20, 32, 33] }

		it "handles them as expected" do
			expected_json = samples_folder + 'sample_output_multi.csv'
			merger.tally_by_voter

			expect(File.read(output)).to eq(File.read(expected_json))			
		end
	end
end