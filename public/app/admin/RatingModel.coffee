angular.module 'app'
  .factory 'RatingModel', ($resource) ->
    RatingResource = $resource '/api/ratings/:id', {_id: "@id"},
      update: { method: 'PUT', isArray: false }

    RatingResource