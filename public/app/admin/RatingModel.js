// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('RatingModel', function($resource) {
    return $resource('/api/ratings/:id', {
      _id: "@id"
    }, {
      update: {
        method: 'PUT',
        isArray: false
      }
    });
  });

}).call(this);

//# sourceMappingURL=RatingModel.map
