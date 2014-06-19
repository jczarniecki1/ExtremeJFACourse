// Generated by CoffeeScript 1.7.1
(function() {
  angular.module('app').controller('NewChallengeController', function($scope, ChallengeEditor, $location, $routeParams, NotifierService) {
    var courseId;
    courseId = $routeParams.courseId;
    $scope.levels = ["basic", "advanced", "expert"];
    return $scope.create = function() {
      var newChallengeData;
      newChallengeData = {
        description: $scope.description,
        level: $scope.level,
        jsonData: $scope.jsonData,
        initialInput: $scope.initialInput,
        correctAnswerExpression: $scope.correctAnswerExpression,
        courseId: courseId
      };
      return ChallengeEditor.createChallenge(newChallengeData).then(function(challenge) {
        NotifierService.notify('New challenge created successfully');
        return $location.path("/courses/" + courseId + "/challenge/" + challenge._id);
      }, NotifierService.error);
    };
  });

}).call(this);

//# sourceMappingURL=NewChallengeController.map
