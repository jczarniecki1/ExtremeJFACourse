// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').factory('ChallengeModel', function($resource) {
    var ChallengeResource;
    ChallengeResource = $resource('/api/courses/:courseId/challenges/:id', {
      courseId: "@courseId",
      _id: "@id"
    }, {
      update: {
        method: 'PUT',
        isArray: false
      }
    });
    return ChallengeResource;
  });

}).call(this);

//# sourceMappingURL=ChallengeModel.map
