// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('ChallengeModel', function($resource) {
    return $resource('/api/courses/:courseId/challenges/:id', {
      courseId: "@courseId",
      _id: "@id"
    }, {
      update: {
        method: 'PUT',
        isArray: false
      },
      remove: {
        method: 'DELETE',
        isArray: false
      }
    });
  });

}).call(this);

//# sourceMappingURL=ChallengeModel.map
