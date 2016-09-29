require 'net/http'

uri = URI('https://www.govtrack.us/api/v2/bill?congress=114')
res = Net::HTTP.get(uri)
