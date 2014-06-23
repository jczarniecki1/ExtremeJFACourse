// Generated by CoffeeScript 1.7.1
(function() {
  var ObjectId, Rating, mongoose, ratingSchema, ratingType;

  mongoose = require('mongoose');

  ObjectId = mongoose.Schema.Types.ObjectId;

  ratingType = {
    values: 'course challenge'.split(' '),
    message: 'You can rate only existing course or challenge'
  };

  ratingSchema = mongoose.Schema({
    userId: {
      type: ObjectId,
      required: 'Cannot save anonymous rating'
    },
    submitted: {
      type: Date,
      required: 'Rating should have date of submission'
    },
    type: {
      type: String,
      "enum": ratingType,
      required: 'Cannot send rating with unknown type'
    },
    objectId: {
      type: ObjectId,
      required: 'Cannot save rating from unknown location'
    },
    value: {
      type: Number,
      min: 1,
      max: 5,
      required: 'Cannot save rating with unknown value'
    },
    url: {
      type: String,
      required: 'Cannot save rating from unknown location'
    },
    location: {
      type: String,
      required: 'Cannot save rating from unknown location'
    }
  });

  ratingSchema.methods = {
    getData: function() {
      var location, objectId, submitted, type, url, value, _id;
      _id = this._id, submitted = this.submitted, type = this.type, objectId = this.objectId, value = this.value, url = this.url, location = this.location;
      return {
        _id: _id,
        submitted: submitted,
        type: type,
        objectId: objectId,
        value: value,
        url: url,
        location: location
      };
    }
  };

  Rating = mongoose.model('Rating', ratingSchema);

}).call(this);

//# sourceMappingURL=Rating.map
