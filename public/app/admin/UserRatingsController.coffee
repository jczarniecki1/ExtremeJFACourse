angular.module 'app'
.controller 'UserRatingsController', ($scope, $routeParams, UserModel, CachedRating) ->
  userId = $routeParams.userId

  UserModel.query().$promise
  .then (collection) ->
    collection.findById userId, (user) ->
      $scope.user = user

  $scope.ratings = CachedRating.query {userId}


  $scope.range = (value) -> [1..value]
