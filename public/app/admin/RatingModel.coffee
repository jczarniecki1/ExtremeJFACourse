angular.module 'app'
.factory 'RatingModel', ($resource) ->
  $resource '/api/ratings/:id', {_id: "@id"},
    update: { method: 'PUT', isArray: false }
