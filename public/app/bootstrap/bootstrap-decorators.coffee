angular.module 'app'
.config ($provide) ->
  $provide.decorator 'ratingDirective', ($delegate) ->
    $delegate[0].templateUrl = '/partials/bootstrap/rating/rating'
    $delegate