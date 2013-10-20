EtsyApi = require('./etsyApi').EtsyApi
etsy = new EtsyApi('ulcph3lw165dpej53luixdqa', 'aj4g0gp8sg')

exports.getListingHandmadeScore = (listing_id, done) ->
  listing = null
  userProfile = null
  shop = null
  etsy.getListing listing_id, (err, details) =>
    listing = details.results[0]
    etsy.findUserProfile listing.user_id, (err, details) =>
      userProfile = details.results[0]
      etsy.getListingShop listing.listing_id, (err, details) =>
        shop = details.results[0]
        done null, @calculateHandmadeScore
          listing: listing
          userProfile: userProfile
          shop: shop

exports.calculateHandmadeScore = (data) ->
  listing = data.listing
  score = 0
  score+= 10 unless listing.used_manufacturer
  score+= 10 unless listing.is_supply
  score+= 10 if listing.who_made is 'i_did'
  score+= 5  if listing.is_customizable

  score+= 10 if calculateSalesPerDay(data) < 20

  return score

calculateSalesPerDay = (data) ->
  secondsSinceJoining = new Date().getTime()/1000 - data.shop.creation_tsz
  daysSinceJoining = Math.floor(secondsSinceJoining/60/60/24)
  salesPerDay = data.userProfile.transaction_sold_count / daysSinceJoining
  salesPerDay
  
