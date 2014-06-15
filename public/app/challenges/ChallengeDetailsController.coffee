angular.module 'app'
.controller 'ChallengeDetailsController', ($scope, CachedChallenge, CachedCourse, $routeParams, IdentityService) ->
  $scope.identity = IdentityService

  courseId = $routeParams.courseId
  $scope.courseId = courseId
  CachedChallenge.query({courseId}).$promise.then (collection) ->
    $scope.challengeIndex = collection?.findById $routeParams.challengeId, (challenge) ->
      $scope.challenge = challenge
      $('.description').html challenge.description

  CachedCourse.findById courseId, (course) ->
    $scope.course = course