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
    }
  });

  ratingSchema.methods = {
    getData: function() {
      var objectId, type, value, _id;
      _id = this._id, type = this.type, objectId = this.objectId, value = this.value;
      return {
        _id: _id,
        type: type,
        objectId: objectId,
        value: value
      };
    }
  };

  Rating = mongoose.model('Rating', ratingSchema);

}).call(this);

//# sourceMappingURL=Rating.map
