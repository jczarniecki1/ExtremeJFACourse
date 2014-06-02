// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('CachedRating', function(RatingModel, $q) {
    var ratingList;
    ratingList = {};
    return {
      query: function(args) {
        var _name;
        if ((args != null ? args.userId : void 0) != null) {
          return ratingList[_name = args.userId] != null ? ratingList[_name] : ratingList[_name] = RatingModel.query(args);
        } else {
          return ratingList.all != null ? ratingList.all : ratingList.all = RatingModel.query(args);
        }
      },
      findOne: function(args) {
        var $d;
        $d = $q.defer();
        if (args.objectId != null) {
          this.query(args).$promise.then(function(collection) {
            var rating, _i, _len;
            for (_i = 0, _len = collection.length; _i < _len; _i++) {
              rating = collection[_i];
              if (rating.objectId === args.objectId) {
                return $d.resolve(rating);
              }
            }
            return $d.reject();
          });
        } else {
          $d.reject();
        }
        return $d.promise;
      },
      create: function(args) {
        var $d, newRating;
        $d = $q.defer();
        if ((args.objectId != null) && (args.type != null)) {
          newRating = new RatingModel(args);
          newRating.$save().then(function(rating) {
            ratingList.all.$promise.then(function(collection) {
              return collection.push(rating);
            });
            return $d.resolve(rating);
          }, function() {
            return $d.reject();
          });
        } else {
          $d.reject();
        }
        return $d.promise;
      }
    };
  });

}).call(this);

//# sourceMappingURL=CachedRating.map