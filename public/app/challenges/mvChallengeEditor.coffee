angular.module 'app'
  .factory 'mvChallengeEditor', (mvChallenge, $q) ->
    {
      createChallenge: (newChallengeData) ->
        newChallenge = new mvChallenge newChallengeData
        deferred = $q.defer()

        newChallenge.$save()
          .then (challenge) ->
            deferred.resolve challenge
          , (response) ->
            deferred.reject response.data.reason

        deferred.promise
    }