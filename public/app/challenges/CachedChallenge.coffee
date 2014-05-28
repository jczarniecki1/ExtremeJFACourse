angular.module 'app'
  .factory 'CachedChallenge', (ChallengeModel) ->
    challengeList = {}
    {
      query: (args) ->
        if args?.courseId?
          args = { courseId: args.courseId }
          challengeList[args.courseId] ?= ChallengeModel.query args
        else
          challengeList['all'] ?= ChallengeModel.query()
    }