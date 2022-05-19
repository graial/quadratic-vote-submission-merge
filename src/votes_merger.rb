require 'yaml'
require 'csv'

class Voter
  def initialize(address)
    @address = address
    @votes = []
  end

  def add_vote(target, number)
    @votes.push({voted_for: target, votes: number})
  end

  def address
    @address
  end
  def votes
    @votes
  end
  def vote_targets
    @votes.map { |h| h[:voted_for] }.uniq
  end
  def get_votes_by_target(target)
    total = 0
    @votes
      .find_all { |h| h[:voted_for].to_i == target }
      .each do |i| 
        total += i[:votes].to_i 
      end
    return total
  end
end

class VoteMerger
  def initialize(input, output, submissions, *args)
    @votes = []
    @submissions_to_merge = submissions
    @voters = []
    
    CSV.foreach(input, headers: true) do |row| 
      @votes << row
    end

    @input_rows = CSV.read(input, headers: true).count
    @output = output
    
    config_file = 'config.yml'
    if args.count > 0
      args = args[0] 
      if args[:config] 
        config_file = args[:config] 
      end
      if args[:mode] == 'test'
        config_file = 'spec/spec_config.yml'
      end
    end
    @CONFIG = YAML.load(File.read(config_file))
    @output_headers = @CONFIG["output_headers"]
  end

  def load_submissions
    submissions = CSV.read(@CONFIG['submissions'], headers: true)
    @submissions_to_merge.each do |sub|
      result = ''
      submissions.each do |row|
        if row['number'].to_i == sub 
          result = "#{row['number']}-#{row['name']}"
        end
      end
      @output_headers.push(result) if result.length > 0
    end
    @output_headers.push("Max")
  end

  def tally_by_voter
    load_submissions
    process_votes
    CSV.open(@output, "w") do |csv|
      csv << @output_headers
      @voters.each do |voter|
        output = [voter.address]
        (voter.vote_targets && @submissions_to_merge).each do |target|
          output.push(voter.get_votes_by_target(target))
        end
        output.push(output[1..-1].max)
        csv << output
      end
    end
  end

  def process_votes
    @votes.each do |vote|
      unless find_voter_by_address(vote["address"])
        new_voter = Voter.new(vote["address"])
        @voters.push(new_voter)
      end

      voter = find_voter_by_address(vote["address"])
      voter.add_vote(vote['number'], vote['amount'])
    end  
  end

  def find_voter_by_address(address)
    @voters.find { |n| n.address == address }      
  end
end