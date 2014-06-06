angular.module 'app'
.factory 'ChallengeEditor', (ChallengeModel, $q) ->

  class ChallengeEditor

    createChallenge: (newChallengeData) ->
      newChallenge = new ChallengeModel newChallengeData
      deferred = $q.defer()

      newChallenge.$save()
      .then (challenge) ->
        deferred.resolve challenge
      , (error) -> deferred.reject error

      deferred.promise

  new ChallengeEditor()