angular.module 'app'
.controller 'NewChallengeController', ($scope, ChallengeEditor, $location, $routeParams, NotifierService) ->

  courseId = $routeParams.courseId

  $scope.levels = ["basic","advanced","expert"]
  $scope.submit = ->

    newChallengeData =
      description:              $scope.description
      level:                    $scope.level
      jsonData:                 $scope.jsonData
      initialInput:             $scope.initialInput
      correctAnswerExpression:  $scope.correctAnswerExpression
      courseId:                 courseId

    ChallengeEditor.createChallenge newChallengeData
    .then (challenge) ->
      NotifierService.notify 'New challenge created successfully'
      $location.path "/courses/#{courseId}/challenge/#{challenge._id}"
    , NotifierService.error