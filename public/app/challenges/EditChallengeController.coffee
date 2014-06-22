angular.module 'app'
.controller 'EditChallengeController', ($scope, CachedChallenge, $location, $routeParams, NotifierService) ->

  courseId = $routeParams.courseId
  challengeId = $routeParams.challengeId
  $scope.levels = ["basic","advanced","expert"]

  CachedChallenge.query({courseId}).$promise
  .then (collection) ->
    $scope.challengeIndex = collection.findById challengeId, (challenge) ->
      $scope.challenge = challenge
      $scope.description = challenge.description
      $scope.level = challenge.level
      $scope.jsonData = challenge.jsonData
      $scope.initialInput = challenge.initialInput
      $scope.correctAnswerExpression = challenge.correctAnswerExpression

  $scope.submit = ->

    updatedChallengeData =
      description:              $scope.description
      level:                    $scope.level
      jsonData:                 $scope.jsonData
      initialInput:             $scope.initialInput
      correctAnswerExpression:  $scope.correctAnswerExpression

    clone = angular.copy $scope.challenge
    angular.extend clone, updatedChallengeData

    clone.$update({courseId, id:challengeId})
    .then ->
      NotifierService.notify 'Challenge updated successfully'
      angular.extend $scope.challenge, updatedChallengeData
      $location.path "/courses/#{courseId}/challenge/#{challengeId}"
    , NotifierService.errorn