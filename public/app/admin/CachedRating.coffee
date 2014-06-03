angular.module 'app'
.factory 'CachedRating', (RatingModel, $q) ->
  ratingList = {}

  class CachedRating
    query: (args) ->
      if args?.userId?
        ratingList[args.userId] ?= RatingModel.query args
      else
        ratingList.all ?= RatingModel.query args

    findOne: (args) ->
      $d = $q.defer()
      if args.objectId?
        @query(args).$promise.then (collection) ->
          for rating in collection
            if rating.objectId is args.objectId
              return $d.resolve rating
          $d.reject()
      else $d.reject()

      $d.promise

    create: (args) ->
      $d = $q.defer()
      if args.objectId? and args.type?
        newRating = new RatingModel(args)
        newRating.$save()
        .then (rating) ->
          ratingList.all.$promise.then (collection) ->
            collection.push rating

          $d.resolve rating
        , ->
          $d.reject()
      else $d.reject()

      $d.promise

  new CachedRating()