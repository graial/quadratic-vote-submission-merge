require 'rest-client'
require 'json'

base_url = 'https://tokenlog.xyz/'
repo= "commons-stack"
election = "commonsprize"
url = base_url + "/v1/creator_coins/#{repo}/#{election}/stats"
output_folder = "../data/outputs"

puts url

response = RestClient.get(url, headers={})

puts response

File.write(output_folder + "/#{election}.json", JSON.dump(response))