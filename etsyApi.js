//var oauth = require('oauth-client');
var request= require('request');

function EtsyApi(api_key, shared_secret, sandbox) {
  this._api_key= api_key;
  this._shared_secret= shared_secret;

  if(typeof shared_secret == 'string') {
    //this._consumer = oauth.createConsumer(api_key, shared_secret);
    //this._signature = oauth.createHmac(this._consumer);
	}
}

EtsyApi.prototype._get= function(path, callback) {
  request({
      uri: 'https://openapi.etsy.com/v2'+path,
      qs: {
        api_key: this._api_key
      },
      json: true
    },
    function (error, response, body) {
      if (!error && response.statusCode != 200)
        error = new Error(response.statusCode + ': '+body);
      if(error)
        console.error(error);
      callback(error, body);
    }
  );
};

EtsyApi.prototype.getListing= function(id, callback) {
  this._get('/listings/'+id, function(error,body){
    //deal with Etsy returning a sting instead of a boolean
    if(!error && typeof(body.results[0].is_supply) == 'string')
      body.results[0].is_supply= 'false' ? false : true;
    callback(error, body);
  });
};

EtsyApi.prototype.findUserProfile= function(id, callback) {
  this._get('/users/'+id+'/profile', callback);
};

EtsyApi.prototype.getShop= function(id, callback) {
  this._get('/shops/'+id, callback);
};

EtsyApi.prototype.getListingShop= function(id, callback) {
  this._get('/shops/listing/'+id, callback);
};

exports.EtsyApi = EtsyApi;
