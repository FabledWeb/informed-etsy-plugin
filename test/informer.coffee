informer = require "./../informer"

describe "informer", ->

  describe ".calculateHandmadeScore", ->

    describe "not handmade at all", ->
      listing =
        used_manufacturer: true
        who_made: 'not_me'
        is_supply: true
        is_customizable: false

      it "should have a score of 0", ->
        expect(informer.calculateHandmadeScore({listing: listing})).toBe(0)

    describe "very handmade", ->
      listing =
        used_manufacturer: false
        who_made: 'i_did'
        is_supply: false
        is_customizable: true
  
      it "should have a score of 35", ->
        expect(informer.calculateHandmadeScore({listing: listing})).toBe(35)

  describe ".getListingHandmadeScore", ->

    describe "a listing by Leoben", ->

      it "should have a score of 35", ->
        informer.getListingHandmadeScore "160164360", (err, score) ->
          expect(score).toBe(35)
