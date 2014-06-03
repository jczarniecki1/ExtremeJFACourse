angular.module 'app'
.controller 'NewChallengeController', ($scope, ChallengeEditor, $location, $routeParams, NotifierService) ->

  courseId = $routeParams.courseId

  $scope.create = ->

    newChallengeData =
      description: $scope.description
      body:        $scope.body
      score:       $scope.score
      courseId:    courseId

    ChallengeEditor.createChallenge newChallengeData
    .then (challenge) ->
      NotifierService.notify 'New challenge created successfully'
      $location.path "/courses/#{courseId}/challenge/#{challenge._id}"
    , (error) -> NotifierService.error error