informer = require "./../informer"

describe "informer", ->

  describe ".calculateHandmadeScore", ->

    describe "not handmade at all", ->
      data =
        listing:
          used_manufacturer: true
          who_made: 'not_me'
          is_supply: true
          is_customizable: false
        userProfile:
          transaction_sold_count: 100000
        shop:
          creation_tsz: 1282336386

      it "should have a score of 0", ->
        expect(informer.calculateHandmadeScore(data)).toBe(0)

    describe "very handmade", ->
      data =
        listing:
          used_manufacturer: false
          who_made: 'i_did'
          is_supply: false
          is_customizable: true
        userProfile:
          transaction_sold_count: 1
        shop:
          creation_tsz: 1282336386
  
      it "should have a score of 45", ->
        expect(informer.calculateHandmadeScore(data)).toBe(45)

  describe ".getListingHandmadeScore", ->

    describe "a listing by Leoben", ->
      beforeAll (done) ->
        informer.getListingHandmadeScore "160164360", (err, score) =>
          @score = score
          done()

      it "should have a score of 45", ->
        expect(@score).toBe(45)
