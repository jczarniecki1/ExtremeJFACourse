angular.module 'app'
  .controller 'newChallengeController', ($scope, mvChallengeEditor, $location, $routeParams, mvNotifier) ->
    courseId = $routeParams.courseId
    $scope.create = ->

      newChallengeData =
        description: $scope.description
        body: $scope.body
        score: $scope.score
        courseId: courseId

      mvChallengeEditor.createChallenge newChallengeData
        .then (challenge) ->
          mvNotifier.notify 'New challenge created successfully'
          $location.path "/courses/#{courseId}/challenge/#{challenge._id}"
        , (reason) ->
          mvNotifier.error reason