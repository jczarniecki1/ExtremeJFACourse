// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('ChallengeDetailsController', function($scope, CachedChallenge, $routeParams, IdentityService) {
    $scope.identity = IdentityService;
    return CachedChallenge.query({
      courseId: $routeParams.courseId
    }).$promise.then(function(collection) {
      var challenge, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = collection.length; _i < _len; _i++) {
        challenge = collection[_i];
        if (challenge._id === $routeParams.challengeId) {
          $scope.challenge = challenge;
          break;
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    });
  });

}).call(this);

//# sourceMappingURL=ChallengeDetailsController.map
