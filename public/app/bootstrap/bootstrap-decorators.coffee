angular.module 'app'
.config ($provide) ->
  $provide.decorator 'ratingDirective', ($delegate) ->
    $delegate[0].templateUrl = '/partials/bootstrap/rating/rating'
    $delegate
  $provide.decorator 'modalBackdropDirective', ($delegate) ->
    $delegate[0].templateUrl = '/partials/bootstrap/modal/backdrop'
    $delegate
  $provide.decorator 'modalWindowDirective', ($delegate) ->
    $delegate[0].templateUrl = '/partials/bootstrap/modal/window'
    $delegate