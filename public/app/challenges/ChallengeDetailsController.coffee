angular.module 'app'
.controller 'ChallengeDetailsController', ($scope, CachedChallenge, CachedCourse, $routeParams, ControlsProvider, IdentityService, $location) ->
  $scope.identity = IdentityService

  courseId = $routeParams.courseId
  $scope.courseId = courseId
  CachedChallenge.query({courseId}).$promise.then (collection) ->
    $scope.challengeIndex = collection.findById $routeParams.challengeId, (challenge) ->
      $scope.challenge = challenge

      # Set data for control
      angular.extend challenge.config,
        title: challenge.title
        instruction: challenge.description

      # Init control for challenge
      controller = ControlsProvider.findById challenge.control
      controller.init $('.challenge-body'), challenge.config

    $scope.skip = ->
      nextIndex = $scope.challengeIndex + 1
      if collection.length > nextIndex
        nextChallenge = collection[nextIndex]
        $location.path "/courses/#{courseId}/challenge/#{nextChallenge._id}"

  CachedCourse.findById courseId, (course) ->
    $scope.course = course
