angular.module 'app'
  .controller 'challengeDetailsController', ($scope, mvChallenge, $routeParams, mvIdentity) ->
      $scope.identity = mvIdentity
      mvChallenge.query().$promise.then (collection) ->
        collection.forEach (challenge) ->
          if challenge._id is $routeParams.challengeId
            $scope.challenge = challenge
            false