angular.module 'app'
.factory 'CachedChallenge', (ChallengeModel) ->
  challengeList = {}
  class CachedChallenge
    query: (args) ->
      if args?.courseId?
        args = { courseId: args.courseId }
        challengeList[args.courseId] ?= ChallengeModel.query args
      else
        challengeList['all'] ?= ChallengeModel.query()

  new CachedChallenge()