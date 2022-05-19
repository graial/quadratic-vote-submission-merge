require 'csv'
require 'json'

headers = ["closed","_id","org","repo","number","amount","cost","tokenAddress","timestamp","address","signature","__v"]

filename = "votes"
data_folder = "data/"
output_folder = "data/outputs/"

CSV.open(output_folder + filename + ".csv", "w") do |csv|
  csv << headers

  file = File.read(data_folder + filename + ".json")
  data_hash = JSON.parse(file)

  data_hash.each do |line|
    csv << CSV::Row.new(line.keys, line.values)
  end

end