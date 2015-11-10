colors = Hash.new 

query   = {}
headers = { "Auth-Token"=> "8781974720909019987",}

HTTParty.post("https://www.acb.com/api/v2/market/LTC_BTC/", :query => query, :headers => headers )
"0A".hex