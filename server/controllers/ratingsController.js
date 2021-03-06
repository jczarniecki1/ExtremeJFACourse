// Generated by CoffeeScript 1.7.1
(function() {
  var Challenge, Course, ObjectId, Rating, mongoose;

  mongoose = require('mongoose');

  Rating = mongoose.model('Rating');

  Course = mongoose.model('Course');

  Challenge = mongoose.model('Challenge');

  Challenge = mongoose.model('Challenge');

  ObjectId = mongoose.Schema.Types.ObjectId;

  exports.getRatings = function(req, res) {
    var userId;
    userId = req.user.hasRole('admin') ? req.url.match(/=.*/)[0].substr(1) : req.user._id;
    return Rating.find({
      userId: userId
    }).exec(function(err, collection) {
      return res.send(collection != null ? collection.map(function(x) {
        return x.getData();
      }) : void 0);
    });
  };

  exports.addRating = function(req, res, next) {
    var model, ratingData;
    ratingData = req.body;
    ratingData.userId = req.user._id;
    model = ratingData.type === 'course' ? Course : Challenge;
    return model.findOne({
      _id: ratingData.objectId
    }).exec(function(err, element) {
      if (err != null) {
        return res.SendError(err);
      }
      ratingData.objectId = element._id;
      ratingData.submitted = new Date();
      return Rating.create(ratingData, function(err, rating) {
        if (err != null) {
          return res.SendError(err);
        }
        res.status(200);
        req.user.ratingCount++;
        element.updateRating();
        req.user.save();
        return res.send(rating.getData());
      });
    });
  };

  exports.updateRating = function(req, res, next) {
    return Rating.findOne({
      _id: req.body._id
    }).exec(function(err, rating) {
      if (err != null) {
        return res.SendError(err);
      }
      rating.value = req.body.value;
      rating.submitted = new Date();
      return rating.save(function(err) {
        var model;
        if (err != null) {
          return res.SendError(err);
        }
        model = rating.type === 'course' ? Course : Challenge;
        model.findOne({
          _id: rating.objectId
        }).exec(function(err, element) {
          if (err == null) {
            return element.updateRating();
          }
        });
        return res.send(rating.getData());
      });
    });
  };

}).call(this);

//# sourceMappingURL=ratingsController.map
