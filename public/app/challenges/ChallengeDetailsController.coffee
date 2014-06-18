angular.module 'app'
.controller 'ChallengeDetailsController', ($scope, CachedChallenge, CachedCourse, $routeParams, IdentityService, $location) ->
  $scope.identity = IdentityService

  courseId = $routeParams.courseId
  $scope.courseId = courseId
  CachedChallenge.query({courseId}).$promise.then (collection) ->
    $scope.challengeIndex = collection.findById $routeParams.challengeId, (challenge) ->
      $scope.challenge = challenge
      $('.description').html challenge.description

    $scope.skip = ->
      nextIndex = $scope.challengeIndex + 1
      if collection.length > nextIndex
        nextChallenge = collection[nextIndex]
        $location.path "/courses/#{courseId}/challenge/#{nextChallenge._id}"

  CachedCourse.findById courseId, (course) ->
    $scope.course = course

