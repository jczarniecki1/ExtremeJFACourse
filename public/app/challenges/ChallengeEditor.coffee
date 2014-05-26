angular.module 'app'
  .factory 'ChallengeEditor', (ChallengeModel, $q) ->
    {
      createChallenge: (newChallengeData) ->
        newChallenge = new ChallengeModel newChallengeData
        deferred = $q.defer()

        newChallenge.$save()
          .then (challenge) ->
            deferred.resolve challenge
          , (response) ->
            deferred.reject response.data.reason

        deferred.promise
    }