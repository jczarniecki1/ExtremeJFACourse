angular.module 'app'
  .controller 'ChallengeDetailsController', ($scope, CachedChallenge, $routeParams, IdentityService) ->
    $scope.identity = IdentityService

    CachedChallenge.query
      courseId: $routeParams.courseId
    .$promise.then (collection) ->
      for challenge in collection
        if challenge._id is $routeParams.challengeId
          $scope.challenge = challenge
          break
