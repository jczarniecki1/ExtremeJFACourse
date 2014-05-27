angular.module 'app'
  .controller 'ChallengeDetailsController', ($scope, ChallengeModel, $routeParams, IdentityService) ->
      $scope.identity = IdentityService
      ChallengeModel.query().$promise.then (collection) ->
        collection.forEach (challenge) ->
          if challenge._id is $routeParams.challengeId
            $scope.challenge = challenge
            false