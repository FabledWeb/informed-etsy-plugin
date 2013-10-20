EtsyApi = require('./etsyApi').EtsyApi
etsy = new EtsyApi('ulcph3lw165dpej53luixdqa', 'aj4g0gp8sg')

exports.getListingHandmadeScore = (listing_id, done) ->
  etsy.getListing listing_id, (err, details) =>
    listing = details.results[0]
    done null, @calculateHandmadeScore
      listing: listing
    

exports.calculateHandmadeScore = (data) ->
  listing = data.listing
  handmade = false
  score = 0
  score+= 10 unless listing.used_manufacturer
  score+= 10 unless listing.is_supply
  score+= 10 if listing.who_made is 'i_did'
  score+= 5  if listing.is_customizable

  return score
