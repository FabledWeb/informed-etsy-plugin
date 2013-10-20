EtsyApi = require('./../etsyApi').EtsyApi
api = new EtsyApi('ulcph3lw165dpej53luixdqa', 'aj4g0gp8sg')

describe ".getListing", ->
  listing= null
  userProfile= null
  shop= null
  beforeAll (done) ->
    api.getListing "160164360", (err, details) ->
      listing= details.results[0]
      done()

  beforeAll (done) ->
    api.findUserProfile listing.user_id, (err, details) ->
      userProfile= details.results[0]
      done()

  beforeAll (done) ->
    api.getListingShop listing.listing_id, (err, details) ->
      shop= details.results[0]
      done()

  it "should be flagged as not manufactured", ->
    expect(listing.used_manufacturer).toBe(false)

  it "should be made by the shop owner", ->
    expect(listing.who_made).toBe('i_did')

  it "should not be a supply", ->
    expect(listing.is_supply).toBe(false)

  it "should have a good sales/time ratio", ->
    timeMember= new Date().getTime()/1000 - shop.creation_tsz
    daysMember= Math.floor(timeMember/60/60/24)
    salesPerDay= userProfile.transaction_sold_count / daysMember
    expect(salesPerDay).toBeLessThan(50)

