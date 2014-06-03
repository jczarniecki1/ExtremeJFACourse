angular.module 'app'
.controller 'ChallengeDetailsController', ($scope, CachedChallenge, $routeParams, IdentityService) ->
  $scope.identity = IdentityService

  courseId = $routeParams.courseId
  CachedChallenge.query({courseId}).$promise.then (collection) ->
    collection?.findById $routeParams.challengeId, (challenge) ->
      $scope.challenge = challenge
