angular.module 'app'
  .factory 'CachedRating', (RatingModel, $q) ->
    ratingList = {}
    {
      query: (args) ->
        if args?.userId?
          args = { userId: args.userId }
          ratingList[args.userId] ?= RatingModel.query args
        else
          $.defer().reject "Cannot find ratings without User ID"
    }