angular.module 'app'
.factory 'CachedChallenge', (ChallengeModel, $q) ->
  challengeList = {}
  class CachedChallenge
    query: (args) ->
      if args?.courseId?
        args = { courseId: args.courseId }
        challengeList[args.courseId] ?= ChallengeModel.query args
      else
        challengeList['all'] ?= ChallengeModel.query()

    remove: (courseId, id) ->
      $d = $q.defer()

      challengeList[courseId].$promise
      .then (collection) ->
        collection.findById id, (challenge) ->
          challenge.$remove({courseId, id})
          .then ->
            collection.remove(challenge) and $d.resolve()
          , (response) ->
            $d.reject response.data.reason
        , -> $d.reject "Challenge not found"

      $d.promise

  new CachedChallenge()