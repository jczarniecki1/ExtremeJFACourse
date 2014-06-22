// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('ChallengeController', function($scope, $routeParams, CachedChallenge, CachedCourse, $location, NotifierService) {
    var courseId;
    courseId = $routeParams.id;
    CachedCourse.query().$promise.then(function(collection) {
      return collection.findById(courseId, function(course) {
        var _ref;
        $scope.course = course;
        if ((_ref = $scope.identity.currentUser) != null ? _ref.courses.any(function(x) {
          return x.id === courseId;
        }) : void 0) {
          return $scope.course.started = true;
        }
      });
    });
    $scope.challenges = CachedChallenge.query({
      courseId: courseId
    });
    $scope.open = function(id) {
      return $location.path("/courses/" + courseId + "/challenge/" + id);
    };
    $scope.edit = function(id) {
      return $location.path("/courses/" + courseId + "/challenge/edit/" + id);
    };
    return $scope["delete"] = function(id) {
      return CachedChallenge.remove(courseId, id).then(function() {
        return NotifierService.notify("Challenge removed successfully");
      }, function(error) {
        return NotifierService.error(error);
      });
    };
  });

}).call(this);

//# sourceMappingURL=ChallengeController.map
